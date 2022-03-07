function Get-ApplicationToken {
    [cmdletbinding()]
    param (
        [parameter(Mandatory = $true)]
        [string]$clientID,

        [parameter(Mandatory = $true)]
        [string]$clientSecret,

        [parameter(Mandatory = $true)]
        [ValidateSet(
        'https://graph.microsoft.com','https://graph.microsoft.us','https://dod-graph.microsoft.us'
        )]
        [string]$Resource,

        [parameter(Mandatory = $true)]
        [string]$tenantName
    )


    begin{
        if ($Resource -eq 'https://graph.microsoft.com') { $AADLoginURI = 'https://login.microsoftonline.com' }
        elseif ($Resource -eq 'https://graph.microsoft.us') { $AADLoginURI = 'https://login.microsoftonline.us' }
        elseif ($Resource -eq 'https://dod-graph.microsoft.us') { $AADLoginURI = 'https://login.microsoftonline.us' }
    }
    process{
        Try {
            $params = @{
                Uri         = "$AADLoginURI/$TenantName/oauth2/v2.0/token"
                Method      = "POST"
                ErrorAction = "Stop"
            }
            $ReqTokenBody = @{
                Grant_Type    = "client_credentials"
                Scope         = "$($Resource)/.default"
                client_Id     = $clientID
                Client_Secret = $clientSecret
            }
            $TokenResponse = Invoke-RestMethod @params -Body $ReqTokenBody
            return $TokenResponse.access_token
        } 
        catch {
            $_
            #[System.ApplicationException]::new("Failed to aquire token")
        }
    }
    end{}
}