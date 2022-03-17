# ADDSPasswordNotification
Solution to send password expiring notifications to ADDS users using O365 Mailbox

## Getting Started

1. First Save the below script into a directory

    ```PowerShell
    [cmdletbinding()]
    param (
        $CredentialPath = '',
        $clientID = '',
        $resource = 'https://graph.microsoft.com',
        $tenantName = '',
        $SendEmailAccount = '',
        $TestAddress = '',
        $TextToAddToEmail = @"
        To change your password on a PC press CTRL ALT Delete and choose Change Password
        Line2 goes here
        Line 3 goes here
"@,
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
        foreach ($user in $ListOfUsers) {
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
    ```

2. Create an application within AAD and provide it Mail.Send Graph permissions

3. Create a client secret for the application

4. Create a shared mailbox within O365

5. Copy the clientID, tenantName, and shared mailbox name and place in the parameters at the top of the script

    ```PowerShell
    $clientID = 'ClientID GUID',
    $tenantName = 'mytenant.onmicrosoft.com',
    $SendEmailAccount = 'mysharedmailbox.mydomain.com',
    ```

6. If testing enter in the test address that all emails will go to within the TestAddress paramter

7. Save the application secret to a PScredential file.

    ```PowerShell
        $appsecret = 'secret'
        $cred = [system.management.automation.pscredential]::new('application',(Convertto-SecureString $appsecret -asplaintext -force))
        $cred | Export-Clixml -path c:\temp\app.credential
    ```
