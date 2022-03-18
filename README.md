# ADDSPasswordNotification
Solution to send password expiring notifications to ADDS users using O365 Mailbox. It is suggested that you review the article located here: https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/microsoft-365-password-expiration-notification-email-solution/ba-p/2796353

## Getting Started

1. First Save the below script into a directory. A suggested name would be PWExpireNotification.ps1

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

2. Install the PWExpireNotification PowerShell module. You can do this by copying the module directly from GitHub into your local computer PowerShell module store, or running the following PowerShell command:

   ```PowerShell
    Install-module PWExpireNotification,
    ``` 

3. Create an application within AAD and provide it Mail.Send Graph permissions

4. Create a client secret for the application. Do not forget to copy the secret to your clipboard or you will be forcet to recreate it.

5. Create a shared mailbox within O365

6. Copy the clientID, tenantName, and shared mailbox name and place in the parameters at the top of the script
#The clientID is the Application ID created above.

    ```PowerShell
    $clientID = 'ClientID GUID',
    $tenantName = 'mytenant.onmicrosoft.com',
    $SendEmailAccount = 'mysharedmailbox.mydomain.com',
    ```

7. If testing enter in the test address that all emails will go to within the $TestAddress paramter

8. Save the application secret to a PScredential file.

    ```PowerShell
        $appsecret = 'secret'
        $cred = [system.management.automation.pscredential]::new('application',(Convertto-SecureString $appsecret -asplaintext -force))
        $cred | Export-Clixml -path c:\temp\app.credential
    ```
