# Set your Bitbucket credentials and repository information
$Username = "your_username"
$Password = "your_password"
$RepoUrl = "https://bitbucket.org/repository_owner/repository_name.git"
$ClonePath = "path_to_clone_folder"
$DestinationPath = "path_to_destination_folder"

# Construct the clone URL with credentials embedded
$CloneUrl = "https://$Username:$Password@$RepoUrl"

# Clone the repository
Start-Process "git" -ArgumentList "clone $CloneUrl $ClonePath" -NoNewWindow -Wait

# Define an array of client folder names (you can fetch this dynamically if needed)
$ClientFolders = @("client_folder_1", "client_folder_2", "client_folder_3")

# Prompt the user to choose a client folder
Write-Host "Choose a client folder to copy:"
for ($i = 0; $i -lt $ClientFolders.Length; $i++) {
    Write-Host "$($i + 1). $($ClientFolders[$i])"
}
$choice = Read-Host "Enter the number of the client folder"

# Validate user input
if ($choice -ge 1 -and $choice -le $ClientFolders.Length) {
    $selectedClientFolder = $ClientFolders[$choice - 1]
    Write-Host "Selected client folder: $selectedClientFolder"
    # Copy the selected client folder to the destination folder
    Copy-Item -Path "$ClonePath/$selectedClientFolder" -Destination $DestinationPath -Recurse -Force

    # Remove the cloned repository
    Remove-Item -Path $ClonePath -Recurse -Force
} else {
    Write-Host "Invalid choice. Please enter a valid number."
}
