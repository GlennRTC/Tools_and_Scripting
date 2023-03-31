# Set dummy variables
$user = "username"
$password = "password"
$host = "example.com"
$remotePath = "/path/to/remote/folder/"
$localPath = "C:\path\to\local\file.txt"

# Load assembly and set up session options
Add-Type -Path "WinSCPnet.dll"
$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Sftp
    HostName = $host
    UserName = $user
    Password = $password
}

# Connect to session and transfer file
$session = New-Object WinSCP.Session
try
{
    $session.Open($sessionOptions)
    $transferResult = $session.PutFiles($localPath, $remotePath)
    $transferResult.Check()
}
finally
{
    $session.Dispose()
}

# Exit PowerShell
Exit
