Function LogWriter
{
    Param ([string]$logstring)
    Add-Content $logfile -value $logstring
}

add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
        return true;
    }
}
"@
$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

##### Define Variables ######
$date_stamp=(Get-Date).ToString('yyyyMMddTHHmmssffffZ')
$logfile="$env:temp\solarishotrecover-$date_stamp-output.log"
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
$ColdWalletPassword = Read-Host -Prompt "`nPassword for the Hot Wallet"

$TransactionId = Read-Host -Prompt "`nTransaction ID of the deposit to the Hot Wallet address"

##### Where do you want to return the funds to? ######
$ReturnAddress = Read-Host -Prompt "`nWhat address do you want to withdraw to?"
$Amount = Read-Host -Prompt "`nConfirm how many coins you wish to withdraw?" 

##### Prepare the tx ######
Write-Host "`n* Preparing to withdraw from your Hot Wallet and return funds ... please wait." -ForegroundColor DarkCyan

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
			amount = $Amount
		}
	)
    feeType = "low"
} | ConvertTo-Json
$response = Invoke-WebRequest "http://localhost:62000/api/Wallet/build-transaction" -Method Post -Body $json -ContentType 'application/json-patch+json'
$result = $response.Content | ConvertFrom-Json
$ColdStakingTX = $result.transactionHex
LogWriter @result

##### Transmit the  tx ######
Write-Host "`n* Broadcasting your withdrawal transaction ... please wait." -ForegroundColor DarkCyan
$json = @{
    hex = $ColdStakingTX
} | ConvertTo-Json
$response = Invoke-WebRequest "http://localhost:62000/api/Wallet/send-transaction" -Method Post -Body $json -ContentType 'application/json-patch+json'
$result = $response.Content | ConvertFrom-Json
LogWriter @result 
LogWriter "** End of Log **"

Write-Host "`nTransaction complete.  Here are your withdrawal transaction details:" 
Write-Host "Return address:" $ReturnAddress
Write-Host "Amount        :" $Amount
Write-Host "Hex or error  :" $ColdStakingTX "`n"
