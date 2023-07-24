#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 subdirectory search_strings..."
  exit 1
fi

# Get the subdirectory path from the first argument
subdirectory="$1"
shift

# Loop over the remaining arguments (search strings)
for search_string in "$@"; do
  echo "Searching for '$search_string' in subdirectory '$subdirectory':"

  # Use ripgrep to search for the string in the subdirectory
  # The "-l" flag tells ripgrep to only output the names of files that have a match
  # The "-r" flag enables recursive searching
  # The "-F" flag treats the search string as a literal string
  # The "--color=always" flag enables colored output
  # The "--no-messages" flag suppresses error messages from being displayed
  # The "--hidden" flag searches hidden files and directories
  # The "--ignore-case" flag makes the search case-insensitive
  # You can customize these flags as per your requirements.
  rg -lFr --color=always --no-messages --hidden --ignore-case "$search_string" "$subdirectory"
  echo
done
