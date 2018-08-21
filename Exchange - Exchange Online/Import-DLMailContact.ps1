$Path = '#CSV File that Contains SMTP Address and a Display Name'
$DL = '#Distribution List to to the Mail contact to'


$Data = Import-Csv -Path $Path 
$OU = '#DN of the OU to Contain the Mail Contact'

#New-MailContact

$Data | % {

    New-MailContact -ExternalEmailAddress $_.ExternalEmail -Name $_.DisplayName -OrganizationalUnit $OU -Confirm

    Set-Mailcontact -identity $_.DisplayName -HiddenFromAddressListsEnabled $true

    Add-DistributionGroupMember -identity $DL -Member $_.DisplayName
