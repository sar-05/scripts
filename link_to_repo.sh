#!/usr/bin/env bash

SRC="$HOME/VM_Share/windows_11/Scripts"
TARGET="$HOME/Repos/ejercicios_pc"

get_directories() {
  # Recieves a source to check directories
  # Returns absolute paths to directories in a given directory
  local src="$1"
  for dir in "$src"/*; do
    if [[ -d "$dir" ]]; then
      echo "$dir"
    fi
  done
}

get_files() {
  # Recieves absolute paths of dirs from stdin
  # Returns absolute paths to files in a given directory
  while IFS= read -r dir; do
    for file in "$dir"/*; do
      if [[ -f "$file" ]]; then
        echo -n "$file;" && basename "$dir"
      fi
    done
  done
}

link_files() {
  # Recieves a path;parent string from stdin
  local target="$1"
  while IFS=';' read -r path parent; do
    mkdir -p "$target/$parent"
    ln "$path" "$target/$parent"
  done
}

main() {
  # Recieves SRC and TARGET
  # Executes the link operation
  local src="$1"
  local target="$2"
  get_directories "$src" | get_files | link_files "$target"
}

main "$SRC" "$TARGET"
