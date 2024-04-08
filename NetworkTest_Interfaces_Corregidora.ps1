# Definir la dirección IP o el nombre de host del servidor
$server = "10.0.20.58"

# Crear el archivo de registro
Start-Transcript -Path "C:\Users\Administrador\Documents\PruebasRed\network_tests.log" -Append

# Prueba de ping
Write-Output "Prueba de ping:"
ping $server

# Prueba de traceroute
Write-Output "Prueba de traceroute:"
tracert $server

# Prueba de resolución de nombres
#Write-Output "Prueba de resolución de nombres:"
#nslookup $server

# Prueba de conectividad HTTP
#Write-Output "Prueba de conectividad HTTP:"
#$httpResponse = Invoke-WebRequest -Uri "http://$server" -UseBasicParsing
#$httpResponse.StatusCode

# Prueba de conexion TCP
Write-Output "Prueba de conexión TCP (puerto 5001):"
$nmapPath = "C:\Program Files (x86)\Nmap\nmap.exe"  # Ruta al ejecutable de nmap
try {
    $nmapOutput = & $nmapPath -p 5001 -sV $server
    Write-Output $nmapOutput
	Write-Output "--- Netstat ---"
	$netstatOutput = netstat -np tcp | Select-string -pattern "5001"
    Write-Output $netstatOutput
} catch {
    Write-Output "Error de conexión TCP: $_"
}

Stop-Transcript
