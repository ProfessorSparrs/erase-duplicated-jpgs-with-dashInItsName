#!/bin/bash

# Ask the user for the directory to search in
read -p "Enter the directory path to search for '-x.jpg' files: " search_dir

# Check if the directory exists
if [ ! -d "$search_dir" ]; then
    echo "Directory '$search_dir' does not exist."
        exit 1
        fi

        # Search for '-x.jpg' files with numerical values for 'x' in the specified directory and its subdirectories
        found_files=()
        shopt -s nullglob
        for file in "$search_dir"/*-*.jpg; do
            if [[ $file =~ ([0-9]+)-[0-9]+\.jpg ]]; then
                    found_files+=("$file")
                        fi
                        done

                        # Check if any files were found
                        if [ ${#found_files[@]} -eq 0 ]; then
                            echo "No '-x.jpg' files found in '$search_dir'."
                                exit 0
                                fi

                                # Display the found files
                                echo "Found '-x.jpg' files:"
                                for file in "${found_files[@]}"; do
                                    echo "$file"
                                    done

                                    # Create a shell script to delete the found files
                                    jpg_eraser_script="$search_dir/jpg-eraser_script.sh"
                                    echo "Creating a script to erase the found images: $jpg_eraser_script"

                                    {
                                        echo '#!/bin/bash'
                                            echo 'echo "Erasing images..."'

                                                    for file in "${found_files[@]}"; do
                                                            echo "rm \"$file\""
                                                                done

                                                                        echo 'echo "Images erased successfully!"'
                                                                        } > "$jpg_eraser_script"

                                                                        chmod +x "$jpg_eraser_script"
                                                                        echo "Script created. To erase images, run: ./$jpg_eraser_script"
                                                                       
