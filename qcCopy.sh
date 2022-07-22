$remoteFilePath = '\\Server_index_02\c\Control'
Copy-Item -Path 'F:\OMNILAB\EXE\QCMEXPORTTEMP\*.txt' -Destination $remoteFilePath
Write-Host "I've just copied the file to $remoteFilePath"
Remove-Item "*.txt"

$remoteFilePath = '\\Server_index_02\c\Control'
robocopy 'F:\OMNILAB\EXE\QCMEXPORTTEMP\' $remoteFilePath /MOV