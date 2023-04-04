# Configura Variables de Acceso
$user = "username"
$password = "password"
$host = "example.com"
$remotePath = "/Ordenes/"
$localPath = "D:\OMNILAB\DERIVACIONES\PETICIONES\*.txt"

# Carga modulo Assembly y abre 
Add-Type -Path "WinSCPnet.dll"
$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Sftp
    HostName = $host
    UserName = $user
    Password = $password
}

# Conecta secion y transfiere archivo
$session = New-Object WinSCP.Session
try
{
    $session.Open($sessionOptions)
    $transferResult = $session.PutFiles($localPath, $remotePath)
    $transferResult.Check()
}

# Cierra secion.
finally
{
    $session.Dispose()
}

# Salida PowerShell
Exit
