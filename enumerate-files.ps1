# Prompt the user for the folder path
$folderPath = Read-Host -Prompt "Enter the folder path to enumerate"

# Get all files in the specified folder and subfolders and exclude some extensions
$files = Get-ChildItem -Path $folderPath -Recurse -File | Where-Object { $_.Extension -notin @('.txt', '.log', '.sav') }

# Create an array to store the file information
$fileInfo = @()

# Process each file
foreach ($file in $files) {
    $fileInfo += [PSCustomObject]@{
        FileName = $file.Name
        Path = $file.FullName
        Extension = $file.Extension
    }
}

# Show fileInfo on screen
$fileInfo -NoTypeInformation

Write-Host "File enumeration completed."
