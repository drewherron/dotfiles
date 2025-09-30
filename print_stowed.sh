#!/bin/bash

# Script to print directories that are currently stowed, categorized by stow type

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$(dirname "$DOTFILES_DIR")"
DOTFILES_BASENAME="$(basename "$DOTFILES_DIR")"

# Directories to skip
SKIP_DIRS=(".git" "archive")

# Category arrays
CATEGORY_1=()  # Fully stowed via directory symlinks
CATEGORY_2=()  # Fully stowed via file symlinks
declare -A CATEGORY_3  # Partially stowed - has unstowed files (maps package -> unstowed files)
CATEGORY_4=()  # Not stowed

# Function to check if a path should be ignored based on .stow-local-ignore
should_ignore() {
    local package_dir="$1"
    local rel_path="$2"
    local ignore_file="$package_dir/.stow-local-ignore"

    [[ ! -f "$ignore_file" ]] && return 1

    while IFS= read -r pattern || [[ -n "$pattern" ]]; do
        [[ -z "$pattern" || "$pattern" =~ ^# ]] && continue
        if [[ "$rel_path" == "$pattern"* || "$rel_path" == "$pattern" ]]; then
            return 0
        fi
    done < "$ignore_file"

    return 1
}

# Function to check if a target path is stowed (is a symlink or under a symlinked directory)
is_path_stowed() {
    local package_name="$1"
    local rel_path="$2"
    local target_path="$TARGET_DIR/$rel_path"

    # Walk up from the target path, checking each level for a symlink back to dotfiles
    local check_path="$target_path"
    local check_rel="$rel_path"

    while [[ "$check_path" != "$TARGET_DIR" && -n "$check_rel" ]]; do
        if [[ -L "$check_path" ]]; then
            local link_target
            link_target="$(readlink "$check_path")"

            # Resolve relative symlinks to absolute paths
            local resolved_target
            if [[ "$link_target" != /* ]]; then
                # Relative symlink - resolve it relative to the symlink's directory
                local link_dir="$(dirname "$check_path")"
                local link_basename="$(basename "$link_target")"
                local link_dirname="$(dirname "$link_target")"

                if [[ "$link_dirname" != "." ]]; then
                    local resolved_dir
                    resolved_dir="$(cd "$link_dir" && cd "$link_dirname" 2>/dev/null && pwd)"
                    if [[ -n "$resolved_dir" ]]; then
                        resolved_target="$resolved_dir/$link_basename"
                    fi
                else
                    resolved_target="$link_dir/$link_basename"
                fi
            else
                resolved_target="$link_target"
            fi

            local expected_target="$DOTFILES_DIR/$package_name/$check_rel"

            # Check if it points to our dotfiles package
            if [[ "$link_target" == "$DOTFILES_BASENAME/$package_name/$check_rel" ]] || \
               [[ "$resolved_target" == "$expected_target" ]]; then
                # Return the relative path of what's symlinked
                echo "$check_rel"
                return 0
            fi
        fi

        # Move to parent
        check_path="$(dirname "$check_path")"
        check_rel="$(dirname "$check_rel")"
        [[ "$check_rel" == "." ]] && break
    done

    return 1
}

# Function to analyze a package directory
analyze_package() {
    local package_dir="$1"
    local package_name="$(basename "$package_dir")"

    # Find all files and directories in the package
    local all_items=()
    local stowed_items=()
    local ignored_items=()
    local symlinked_dirs=()

    # Get all files (we'll derive directories from these)
    local unstowed_items=()
    while IFS= read -r file; do
        local rel_path="${file#$package_dir/}"
        [[ "$rel_path" == ".stow-local-ignore" ]] && continue

        all_items+=("$rel_path")

        if should_ignore "$package_dir" "$rel_path"; then
            ignored_items+=("$rel_path")
        else
            # Check if this path is stowed
            local stowed_at
            if stowed_at=$(is_path_stowed "$package_name" "$rel_path"); then
                stowed_items+=("$rel_path")
                # Track if it's under a directory symlink (stowed_at != rel_path)
                if [[ "$stowed_at" != "$rel_path" ]]; then
                    # Add to symlinked_dirs if not already there
                    local found=0
                    for d in "${symlinked_dirs[@]}"; do
                        [[ "$d" == "$stowed_at" ]] && found=1 && break
                    done
                    [[ $found -eq 0 ]] && symlinked_dirs+=("$stowed_at")
                fi
            else
                # Not stowed and not ignored
                unstowed_items+=("$rel_path")
            fi
        fi
    done < <(find "$package_dir" -type f -o -type l)

    # Calculate non-ignored items
    local non_ignored_count=$((${#all_items[@]} - ${#ignored_items[@]}))

    # Categorize
    if [[ ${#stowed_items[@]} -eq 0 ]]; then
        # Nothing is stowed
        CATEGORY_4+=("$package_name")
    elif [[ ${#stowed_items[@]} -eq $non_ignored_count ]]; then
        # Everything non-ignored is stowed (fully stowed)
        if [[ ${#symlinked_dirs[@]} -gt 0 ]]; then
            # Has directory symlinks
            CATEGORY_1+=("$package_name")
        else
            # All files individually symlinked
            CATEGORY_2+=("$package_name")
        fi
    else
        # Partially stowed - some non-ignored items are not stowed
        # Store package name and unstowed files list
        local unstowed_list=$(printf '%s\n' "${unstowed_items[@]}")
        CATEGORY_3["$package_name"]="$unstowed_list"
    fi
}

# Main logic
cd "$DOTFILES_DIR" || exit 1

for dir in */; do
    dir="${dir%/}"

    [[ -L "$dir" ]] && continue
    for skip in "${SKIP_DIRS[@]}"; do
        [[ "$dir" == "$skip" ]] && continue 2
    done

    analyze_package "$DOTFILES_DIR/$dir"
done

# Print results
if [[ ${#CATEGORY_1[@]} -gt 0 ]]; then
    echo "=== Fully stowed (directory symlinks) ==="
    printf '%s\n' "${CATEGORY_1[@]}"
    echo
fi

if [[ ${#CATEGORY_2[@]} -gt 0 ]]; then
    echo "=== Fully stowed (file symlinks) ==="
    printf '%s\n' "${CATEGORY_2[@]}"
    echo
fi

if [[ ${#CATEGORY_3[@]} -gt 0 ]]; then
    echo "=== Partially stowed (has unstowed files) ==="
    for package in "${!CATEGORY_3[@]}"; do
        echo "$package"
        # Print unstowed files indented
        while IFS= read -r file; do
            [[ -n "$file" ]] && echo "  $file"
        done <<< "${CATEGORY_3[$package]}"
    done | sort
    echo
fi

if [[ ${#CATEGORY_4[@]} -gt 0 ]]; then
    echo "=== Not stowed ==="
    printf '%s\n' "${CATEGORY_4[@]}"
fi
