# Set the Bitbucket repository URL
$repoUrl = "https://bitbucket.org/yourusername/yourrepository"

# Set the folder you want to download
$folderPath = "path/to/folder"

# Set the destination folder on the client machine
$destinationFolder = "C:\Path\To\Client\Folder"

# Clone the repository to a temporary directory
$tempDirectory = [System.IO.Path]::GetTempPath() + [System.IO.Path]::GetRandomFileName()
git clone $repoUrl $tempDirectory

# Move the desired folder to the destination folder
Move-Item -Path "$tempDirectory\$folderPath" -Destination $destinationFolder -Force

# Clean up the temporary directory
Remove-Item -Path $tempDirectory -Recurse -Force
