$serviceName = "Omnilab_Analyser_Manager_TWM_TRK"
$timestamp = Get-Date -Format "yyyyMMddHHmmss"
$LogPath = "C:\Users\Administrator\Desktop\TWM_TRK_MemoryMonitoring"

$process = Get-CimInstance Win32_Service | Where-Object { $_.Name -eq $serviceName } | ForEach-Object {
    Get-Process -Id $_.ProcessId
}

if ($process) {
    $memoryUsedMB = [math]::Round($process.WorkingSet64 / 1MB, 2)
    
    $result = [PSCustomObject]@{
        Timestamp   = $timestamp
        ServiceName = $serviceName
        MemoryUsedMB = $memoryUsedMB
    }

    $result | Export-Csv -Path "$LogPath\MemoryUsage-$serviceName.csv" -NoTypeInformation -Append
    Write-Output "Memory usage for $serviceName written to 'MemoryUsage.csv' with timestamp."
} else {
    Write-Output "No process found for service: $serviceName"
}
