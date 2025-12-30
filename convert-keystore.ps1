$keystorePath = "android\app\fu-keystore.jks"
$outputPath = "keystore_base64.txt"

if (Test-Path $keystorePath) {
    $bytes = [System.IO.File]::ReadAllBytes($keystorePath)
    $base64 = [System.Convert]::ToBase64String($bytes)
    $base64 | Out-File -Encoding ASCII -FilePath $outputPath
    Write-Host "Keystore converted successfully!"
    Write-Host "Output saved to: $outputPath"
    Write-Host "File size: $((Get-Item $outputPath).Length) bytes"
} else {
    Write-Host "ERROR: Keystore file not found at: $keystorePath"
    exit 1
}

