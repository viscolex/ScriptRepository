Function LogWriter
{
    Param ([string]$logstring)
    Add-Content $logfile -value $logstring
}

##### Define Variables ######
$apiport=62000
$date_stamp=(Get-Date).ToString('yyyyMMddTHHmmssffffZ')
$logfile="$env:temp\trustaking-$date_stamp-output.log"
$ColdWalletName="WalletName"
$ColdWalletPassword=""
$ColdStakingAmount=""
$ColdStakingTX=""

######## Get some information from the user about the wallet ############
Clear-Host
$response = Read-Host -Prompt "Please enter your Wallet Name " 
if ($response) {
    $ColdWalletName = $response
}
$ColdWalletPassword = Read-Host -Prompt "`nPassword for Cold Wallet"

$TransactionId = Read-Host -Prompt "`nTransaction ID of the deposit to the Hot Wallet address"

##### Where do you want to return the funds to? ######
$ReturnAddress = Read-Host -Prompt "`nWhat address do you want to withdraw to?"
$Amount = Read-Host -Prompt "`nConfirm how many coins you wish to withdraw from Cold Staking" 

##### Prepare the cold staking cancel tx ######
Write-Host "`n* Preparing to withdraw from your cold staking and return funds ... please wait." -ForegroundColor DarkCyan

 $json = @{
    password = $ColdWalletPassword
	walletName = $ColdWalletName
	accountName = "coldStakingHotAddresses"
	outpoints = @(
		@{
			transactionId = $TransactionId
			index = 1
		}
	)
	recipients = @(
		@{
			destinationAddress = $ReturnAddress
			amount = "5"
		}
	)
    feeType = "low"
} | ConvertTo-Json
$response = Invoke-WebRequest "http://localhost:$apiport/api/Wallet/build-transaction" -Method Post -Body $json -ContentType 'application/json-patch+json'
$result = $response.Content | ConvertFrom-Json
$ColdStakingTX = $result.transactionHex
LogWriter @result

##### Transmit the cold staking tx ######
Write-Host "`n* Broadcasting your your cold staking withdrawal transaction ... please wait." -ForegroundColor DarkCyan
$json = @{
    hex = $ColdStakingTX
} | ConvertTo-Json
$response = Invoke-WebRequest "http://localhost:$apiport/api/Wallet/send-transaction" -Method Post -Body $json -ContentType 'application/json-patch+json'
$result = $response.Content | ConvertFrom-Json
LogWriter @result 
LogWriter "** End of Log **"

Write-Host "`nTransaction complete.  Here are your withdrawal transaction details:" 
Write-Host "Return address:" $ReturnAddress
Write-Host "Amount        :" $ColdStakingAmount
Write-Host "Hex or error  :" $ColdStakingTX "`n"
