# Carga WinSCP .NET assembly
Add-Type -Path "WinSCPnet.dll"


# Configuracion de sesion y accesos (Estas credenciales son generadas usando el generador de script de sesion de WinSCP para PowerShell)
$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Sftp
    HostName = "xxxxx.com.ar"
    UserName = "xxxx"
    Password = "xxxx"
    SshHostKeyFingerprint = "ssh-rsa 2048 xxxxxxxxxxxxxxxxxxxxxxxxx"
}

$session = New-Object WinSCP.Session

try
{
    # Conexion a Sesion
        $session.Open($sessionOptions)

        # Carga de Ordenes
        $transferOptions = New-Object WinSCP.TransferOptions
        $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary

        $transferResult =
            $session.PutFiles("D:\DERIVACIONES\PETICIONES\*.TXT", "/Ordenes/", $False, $transferOptions)
 

        # Manejo de Errores
        $transferResult.Check()

 

        # Log de resultados del envio
        foreach ($transfer in $transferResult.Transfers)
        {
            Write-Host "Upload of $($transfer.FileName) succeeded"
        }
}

finally
{
    $session.Dispose()
}