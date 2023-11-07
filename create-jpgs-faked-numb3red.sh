#!/bin/bash

# Ask the user for the number of files to create
read -p "Enter the number of fake .jpg files to create: " num_files

# Ask the user for the directory to save the files
read -p "Enter the directory to save the files: " save_dir

# Check if the directory exists
if [ ! -d "$save_dir" ]; then
    echo "Directory '$save_dir' does not exist."
    exit 1
fi

# Loop to create and save fake .jpg files
for ((i = 1; i <= num_files; i++)); do
    # Generate a random SHA-256 hash
    sha256_hash=$(openssl rand -hex 32)
    
    # Create the file with the SHA-256 hash as the filename
    filename="$save_dir/$sha256_hash-$i.jpg"
    touch "$filename"
    
    # Print the verbose information
    echo "Created: $filename"
done

echo "Fake .jpg files created successfully in directory: $save_dir"
