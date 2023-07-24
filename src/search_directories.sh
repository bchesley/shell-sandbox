#!/bin/bash

# Function to search in a specific subdirectory
search_subdirectory() {
  local subdirectory="$1"
  shift

  echo "Searching in subdirectory '$subdirectory':"

  for search_string in "$@"; do
    echo "  Searching for '$search_string':"

    # Use ripgrep with the provided flags to search for the string in the subdirectory
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
}

# Check if the correct number of arguments is provided
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 subdirectory search_strings..."
  exit 1
fi

# Check if the first argument is "."
if [ "$1" = "." ]; then
  # Loop through all subdirectories in the current directory
  for subdirectory in */; do
    [ -d "$subdirectory" ] || continue  # Skip non-directories

    # Apply the search strings to each subdirectory
    search_subdirectory "$subdirectory" "${@:2}"
  done
else
  # If the first argument is not ".", treat it as a specific subdirectory
  search_subdirectory "$@"
fi
