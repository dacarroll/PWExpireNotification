[cmdletbinding()]
param (
    $CredentialPath = '',
    $clientID = '',
    $resource = 'https://graph.microsoft.com',
    $tenantName = '',
    $SendEmailAccount = '',
    $TestAddress = '',
    $TextToAddToEmail = "To change your password on a PC press CTRL ALT Delete and choose Change Password",
    $Signature = "Jolly B. Admin",
    $Logging = $true,
    $ExpireInDaysThreshold = 39
)

#Token
$sec = (Import-Clixml -Path $CredentialPath).GetNetworkCredential().Password

$param = @{
    clientID     = $clientID
    clientSecret = $sec
    resource     = $resource
    tenantName    = $tenantName
}

$token = Get-PWApplicationToken @param

#Get all users

if ($token) {
    $ListOfUsers = Get-PWADDSExpiringPassword
    Write-Verbose ("User Account: {0}, ExpiresOn: {1}, Days: {2} " -f $ListOfUsers[0].Name, $ListOfUsers[0].PasswordExpiresOn, $ListOfUsers[0].PasswordDaystoExpire)
    foreach ($user in $ListOfUsers[0]) {
        $params = @{
            Resource              = $resource
            SendEmailAccount      = $SendEmailAccount
            Token                 = $token
            TestAddress           = $TestAddress
            ADAccount             = $user
            ExpireInDaysThreshold = $ExpireInDaysThreshold
            TextToAdd             = $TextToAddToEmail
            Signature             = $Signature
            Logging               = $true
            
        }
        Send-PWExpiringMailMessage @params -Verbose
    }
}  