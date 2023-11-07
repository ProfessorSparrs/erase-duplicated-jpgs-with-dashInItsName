#!/bin/bash

# Ask the user for the directory to search in
read -p "Enter the directory path to search for '-x.jpg' files: " search_dir

# Check if the directory exists
if [ ! -d "$search_dir" ]; then
    echo "Directory '$search_dir' does not exist."
    exit 1
fi

# Search for '-x.jpg' files in the specified directory and its subdirectories
found_files=($(find "$search_dir" -type f -name '*-*.jpg'))

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
erase_script="$search_dir/erase_images.sh"
echo "Creating a script to erase the found images: $erase_script"

echo '#!/bin/bash' > "$erase_script"
echo 'echo "Erasing images..."' >> "$erase_script"

for file in "${found_files[@]}"; do
    echo "rm -v \"$file\"" >> "$erase_script"
done

echo 'echo "Images erased successfully!"' >> "$erase_script"

chmod +x "$erase_script"
echo "Script created. To erase images, run: ./$erase_script"
