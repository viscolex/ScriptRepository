Function LogWriter
{
    Param ([string]$logstring)
    Add-Content $logfile -value $logstring
}

$json = @{
    receivingAddress = XTToNJrj6DVqEBSR6dHi6v8Lsc7TU4ugr1
    walletName = HotWallet
    walletPassword = Lorien100!
    amount = 5
    fees = 0.0002
} | ConvertTo-Json

$response = Invoke-WebRequest "http://localhost:62000/api/wallet/build-transaction" -Method Post -Body $json -ContentType 'application/json-patch+json'
$result = $response.Content | ConvertFrom-Json
$ColdStakingTX = $result.transactionHex
LogWriter @result

##### Transmit the cold staking tx ######
Write-Host "`n* Broadcasting your your cold staking withdrawal transaction ... please wait." -ForegroundColor DarkCyan
$json = @{
    hex = $ColdStakingTX
} | ConvertTo-Json
$response = Invoke-WebRequest "http://localhost:62000/api/Wallet/send-transaction" -Method Post -Body $json -ContentType 'application/json-patch+json'
$result = $response.Content | ConvertFrom-Json
LogWriter @result 
LogWriter "** End of Log **"