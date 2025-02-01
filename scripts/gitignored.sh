#!/usr/bin/env bash
#
# Usage:
#   ./gitignored.sh
#
# This script finds all Git repositories in or below the current directory,
# then prints out the files that are ignored by each repository.

set -euo pipefail  # safer script settings

# Find all directories named ".git" from the current directory downward
while IFS= read -r -d '' gitdir; do
  # The parent directory of .git is the root of the repository
  reporoot="$(dirname "$gitdir")"

  echo "=== Repository: $reporoot ==="

  # Move into the repo root and list all ignored files
  # --others         => Show untracked files
  # --ignored        => Show ignored files
  # --exclude-standard => Honor standard .gitignore, .git/info/exclude, etc.
  (
    cd "$reporoot"
    git ls-files --others --ignored --exclude-standard
  )

  echo
done < <(find . -type d -name ".git" -print0)
