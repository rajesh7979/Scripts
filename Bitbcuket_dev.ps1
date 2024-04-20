# Set variables
$repoUrl = "https://bitbucket.fis.dev/rest/api/1.0/projects/PROJECT_KEY/repos/repository_name/browse/folder_path?limit=1000"
$username = "your_username"
$password = "your_password"
$outputFolder = "C:\DestinationFolder"

# Base64 encode the username and password for authentication
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username, $password)))

# Function to download files
function Download-Files($url) {
    $response = Invoke-RestMethod -Uri $url -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}
    
    foreach ($file in $response.values) {
        if ($file.type -eq "commit_directory") {
            $newUrl = $file.links.self.href + "?limit=1000"
            Download-Files $newUrl
        } else {
            $fileUrl = $file.links.self.href
            $filePath = $file.path -replace "/", "\"
            $outputFilePath = Join-Path -Path $outputFolder -ChildPath $filePath
            Invoke-WebRequest -Uri $fileUrl -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -OutFile $outputFilePath
        }
    }
}

# Call the function to start downloading files
Download-Files $repoUrl
