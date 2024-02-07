import os
import datetime
import sys

def format_folder_name(folder_name):
    # Replace hyphens with spaces and capitalize each word
    return ' '.join(word.capitalize() for word in folder_name.replace('-', ' ').split())

def create_song_info_file(directory=None):
    # Set directory to the current directory if not specified
    if directory is None:
        directory = os.getcwd()

    try:
        # Get the current date and time
        current_time = datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S")

        # Start with the comment header
        header = f"# File Containing all the Song Names for credits box.\n# File Automatically Created on {current_time}\n\n"
        header += "# Song Name::Song Creator::Song Name Colour::Song Creator Colour::Box Colour::Background Colour::How Long it Stays\n\n"

        # Initialize the content with the header
        content = header

        # File path
        file_path = os.path.join(directory, 'allSongsInfo.txt')

        # Check if the file already exists and prompt for overwrite
        if os.path.exists(file_path):
            response = input("File 'allSongsInfo.txt' already exists. Overwrite? (y/n): ")
            if response.lower() != 'y':
                print("Operation cancelled.")
                return

        # Iterate over folders in the given directory
        for folder in os.listdir(directory):
            if os.path.isdir(os.path.join(directory, folder)):
                formatted_name = format_folder_name(folder)
                entry = f"[{folder}]\n{formatted_name}::CREATOR OF SONG::FFFFFF::FFFFFF::000000::2\n\n"
                content += entry

        # Write the content to a file
        with open(file_path, 'w') as file:
            file.write(content)

        print(f"File 'allSongsInfo.txt' created successfully in {directory}")

    except Exception as e:
        print(f"An error occurred: {e}")

# Check for command-line arguments
if len(sys.argv) > 1:
    if sys.argv[1] == '-h':
        print("Usage: python script_name.py [directory]")
        print("If no directory is specified, the script will run in the current directory.")
        sys.exit()

# Run the script with no arguments for the current directory
create_song_info_file()
