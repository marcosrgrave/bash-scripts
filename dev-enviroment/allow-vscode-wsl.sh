#!bin/bash

# This script allows WSL VSCode to edit files from a specific folder.
# I had an issue trying to edit .sh files in a WSL folder with vscode.
# So, i've found the 'chown' solution and made it a bash script.

if [ "$1" = "" ]
then
    echo "Missing parameter: directory location, e.g., '/home/bash-scripts/'"
    exit 1
else
    directoryName=$1

    username=$(whoami)

    for group in $(groups)
    do 
        currentGroup=$group
        break
    done

    echo "username: $username | group: $currentGroup | directory: $directoryName"
    echo "Allowing vscode to edit '$directoryName' files..."

    sudo chown -R $username:$currentGroup $directoryName

    echo "Process completed successfully. VSCode should be able to edit '$directoryName' files now."
fi