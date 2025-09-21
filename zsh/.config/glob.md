# Zsh Extended Glob Patterns Reference

## Basic Patterns
- `*` - match any string
- `?` - match any single character
- `[abc]` - match any character in brackets
- `[a-z]` - match any character in range

## Negation
- `^pattern` - match anything except pattern
- `^(pattern1|pattern2)` - match anything except pattern1 or pattern2

## Repetition
- `pattern#` - match 0 or more occurrences of pattern
- `pattern##` - match 1 or more occurrences of pattern

## Grouping & Alternatives
- `(pattern1|pattern2)` - match either pattern1 or pattern2
- `pattern~pattern2` - match pattern1 but not pattern2

## Numeric Ranges
- `<1-10>` - match numbers 1 through 10
- `<->` - match any number
- `<1->` - match numbers 1 and higher
- `<-5>` - match numbers up to 5

## Flags
- `(#i)pattern` - case-insensitive matching
- `(#l)pattern` - lowercase matching
- `(#u)pattern` - uppercase matching
- `(#q)` - treat pattern as literal (no globbing)

## Approximate Matching
- `(#a1)pattern` - match pattern with up to 1 error
- `(#a2)pattern` - match pattern with up to 2 errors

## Useful Examples

```bash
# Move all files except specific ones
mv ^(wallpaper|to_organize) to_organize/

# Files ending in .txt but not backup.txt
ls *.txt~backup.txt

# Any file with 1-3 digits in name
ls *<1-3>*

# Case-insensitive search
ls (#i)readme*

# Files modified today (0 days old)
ls *(m0)

# Directories only
ls *(/)

# Executable files only
ls *(*)

# Files larger than 1MB
ls *(Lm+1)

# Combine multiple conditions
ls *(*.jpg|*.png)~*backup*
```

## File Qualifiers
Add these after patterns in parentheses:
- `(/)` - directories only
- `(.)` - regular files only
- `(*)` - executable files
- `(@)` - symbolic links
- `(m0)` - modified today
- `(mh-1)` - modified within last hour
- `(Lm+1)` - larger than 1MB
- `(om)` - order by modification time
- `(On)` - order by name

### File Qualifier Examples

```bash
# List only directories
ls *(/)

# List only regular files (no dirs, links, etc)
ls *(.)

# Find all executable scripts
ls bin/*(*)

# Show symbolic links
ls *(@)

# Files modified in last 24 hours
ls *(mh-24)

# Large files (over 100MB)
ls *(Lm+100)

# Recently modified files, newest first
ls *(om[1,5])

# Combine qualifiers: executable files modified today
ls *(*.)(m0)

# Directories modified in last week, sorted by name
ls *(/.)(mw-1)(On)

# Remove old log files (older than 7 days)
rm logs/*(mw+1)

# Backup recent config files
cp config/*(.)(mw-1) backup/

# Find largest files in directory
ls -la *(Lm+1)(OL)
```