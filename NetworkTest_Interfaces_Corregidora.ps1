# Definir la dirección IP o el nombre de host del servidor
$server = "192.168.1.100"

# Crear el archivo de registro
Start-Transcript -Path "network_tests.log" -Append

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

# Prueba de conexión TCP
Write-Output "Prueba de conexión TCP (puerto 80):"
try {
    $netstatOutput = netstat -np tcp | find "80"
    Write-Output $netstatOutput
} catch {
    Write-Output "Error de conexión TCP: $_"
}

Stop-Transcript