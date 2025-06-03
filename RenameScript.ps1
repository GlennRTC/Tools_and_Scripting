# PowerShell script to rename files by removing "_DUP"
Write-Host "Renaming files to remove '_DUP' from filenames..." -ForegroundColor Green
Write-Host ""

# Get all files in current directory and filter for our pattern
$files = Get-ChildItem -File | Where-Object { $_.Name -like "HOST_Result_HL7_DUP_*" }

foreach ($file in $files) {
    $newName = $file.Name -replace "_DUP_", "_"
    Write-Host "Renaming: '$($file.Name)' to '$newName'" -ForegroundColor Yellow
    
    # Use the full file object instead of just the name
    Rename-Item -LiteralPath $file.FullName -NewName $newName
}

Write-Host ""
Write-Host "Renaming complete!" -ForegroundColor Green
Read-Host "Press Enter to exit"
