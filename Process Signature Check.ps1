# Define output file
$outputFile = "$env:USERPROFILE\Desktop\Process_Signatures.txt"

# Get all running processes
$processes = Get-Process | Select-Object ProcessName, Id, Path
$totalProcesses = $processes.Count
$processedCount = 0

# Start timing
$startTime = Get-Date

# Prepare output
$results = @()
foreach ($process in $processes) {
    $processedCount++
    
    # Estimate time remaining
    $elapsedTime = (Get-Date) - $startTime
    $averageTimePerProcess = if ($processedCount -gt 1) { $elapsedTime.TotalSeconds / $processedCount } else { 0.1 }
    $estimatedRemainingTime = ($totalProcesses - $processedCount) * $averageTimePerProcess
    
    Write-Host "Processing: $($process.ProcessName) ($processedCount / $totalProcesses) - Estimated time left: $([math]::Round($estimatedRemainingTime,2)) sec" -ForegroundColor Yellow
    
    if ($process.Path -and (Test-Path $process.Path)) {
        try {
            $signature = Get-AuthenticodeSignature -FilePath $process.Path
            $signer = if ($signature.SignerCertificate) { $signature.SignerCertificate.Subject } else { "Unsigned" }
            $status = $signature.Status
        } catch {
            $signer = "Error retrieving signature"
            $status = "Unknown"
        }
    } else {
        $signer = "No path available"
        $status = "N/A"
    }
    
    $results += "Process: $($process.ProcessName) | ID: $($process.Id) | Signer: $signer | Status: $status"
}

# Save output to file
$results | Out-File -FilePath $outputFile

Write-Host "Process information saved to $outputFile" -ForegroundColor Green

# Open the output file automatically
Start-Process notepad.exe $outputFile

# Display completion message
Write-Host "Finished! Press CTRL+C or close the window to exit." -ForegroundColor Cyan

# Prevent auto-closing without user input
while ($true) { Start-Sleep -Seconds 1 }
