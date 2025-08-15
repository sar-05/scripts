#!/usr/bin/env bash

SRC="$HOME/VM_Share/windows_11/Scripts"
TARGET="$HOME/Repos/ejercicios_pc"

main() {
    local src="$1"
    local target="$2"
    
    # Validation
    [[ ! -d "$src" ]] && { echo "Error: Source '$src' not found" >&2; exit 1; }
    
    # Create target directory
    mkdir -p "$target"
    
    # Find all files (excluding this script) and create hard links
    find "$src" -type f -not -name "$(basename "$0")" -print0 | while IFS= read -r -d '' file; do
        # Calculate relative path and target location
        local rel_path="${file#"$src"/}"
        local target_file="$target/$rel_path"
        
        # Create directory structure
        mkdir -p "$(dirname "$target_file")"
        
        # Create hard link if target doesn't exist
        if [[ ! -e "$target_file" ]]; then
            if ln "$file" "$target_file" 2>/dev/null; then
                echo "Linked: $rel_path"
            else
                echo "Failed: $rel_path" >&2
            fi
        else
            echo "Exists: $rel_path"
        fi
    done
}

main "$SRC" "$TARGET"
