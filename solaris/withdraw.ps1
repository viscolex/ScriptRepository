Function LogWriter
{
    Param ([string]$logstring)
    Add-Content $logfile -value $logstring
}

##### Define Variables ######
$date_stamp=(Get-Date).ToString('yyyyMMddTHHmmssffffZ')
$logfile="$env:temp\solarishotrecover-$date_stamp-output.log"
$WalletName="WalletName"
$WalletPassword=""
$Amount=""
$ReturnTX=""

######## Get some information from the user about the wallet ############
Clear-Host
$response = Read-Host -Prompt "Please enter your Wallet Name " 
if ($response) {
    $WalletName = $response
}
$WalletPassword = Read-Host -Prompt "`nPassword for the Hot Wallet"

$TransactionId = Read-Host -Prompt "`nTransaction ID of the deposit to the Hot Wallet address"

##### Where do you want to return the funds to? ######
$ReturnAddress = Read-Host -Prompt "`nWhat address do you want to withdraw to?"
$Amount = Read-Host -Prompt "`nConfirm how many coins you wish to withdraw?" 

##### Prepare the tx ######
Write-Host "`n* Preparing to withdraw from your Hot Wallet and return funds ... please wait." -ForegroundColor DarkCyan

 $json = @{
    password = $WalletPassword
	walletName = $WalletName
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
			amount = $Amount
		}
	)
    feeType = "low"
} | ConvertTo-Json
$response = Invoke-WebRequest "http://localhost:62000/api/Wallet/build-transaction" -Method Post -Body $json -ContentType 'application/json-patch+json'
$result = $response.Content | ConvertFrom-Json
$ReturnTX = $result.hex
LogWriter @result

##### Transmit the  tx ######
Write-Host "`n* Broadcasting your withdrawal transaction ... please wait." -ForegroundColor DarkCyan
$json = @{
    hex = "01000000c7cec25d01b5be5d870ab39a2e371d7326cf103721ccb1adf1f33daeb32df918ee9cecb2d2010000006b483045022100a074350be73574a9323b70759417721f99949b80263932a2ba8ca847fe43ea3e02200ea32cb86c42c6a8ed0d00a4209cbeb88fc78ef1ae560eb510bc20fdd383c55e012102604a16d5bca08f4a006da0e1bb989383d58d2b34b015d5351a74c96b6083a7ebffffffff02f03dcd1d000000001976a914b9957a50157d2aa5605565a580350dd753c3aa8888ac0065cd1d000000001976a914b0bfa79a1ab03f89c963806fb4b683a699920a3588ac00000000"
} | ConvertTo-Json
$response = Invoke-WebRequest "http://localhost:62000/api/Wallet/send-transaction" -Method Post -Body $json -ContentType 'application/json-patch+json'
$result = $response.Content | ConvertFrom-Json
LogWriter @result 
LogWriter "** End of Log **"

Write-Host "`nTransaction complete.  Here are your withdrawal transaction details:" 
Write-Host "Return address:" $ReturnAddress
Write-Host "Amount        :" $Amount
Write-Host "Hex or error  :" $ReturnTX "`n"
