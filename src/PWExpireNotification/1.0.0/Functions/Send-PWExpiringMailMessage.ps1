function Send-PWExpiringMailMessage {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [ValidateSet(
        'https://graph.microsoft.com','https://graph.microsoft.us','https://dod-graph.microsoft.us'
        )]
        [string]$Resource,

        [parameter(Mandatory = $true)]
        [string]$SendEmailAccount,

        [parameter(Mandatory = $True)]
        [string]$Token,

        [parameter(Mandatory = $false)]
        [string]$TestAddress,

        [parameter(Mandatory = $true)]
        [PSCustomObject]$ADAccount,

        [parameter(Mandatory = $true)]
        [string]$Signature,

        [parameter(Mandatory = $true)]
        [string]$TextToAdd,

        [int]$ExpireInDaysThreshold = 30,

        [Parameter(
            ParameterSetName = 'Log'
        )]
        [switch]$Logging,

        [Parameter(
            ParameterSetName = 'Log'
        )]
        [string]$LogFile = "$($PWD.Path)\Expiring.csv" # ie. c:\mylog.csv
    )
    begin{
        <#TODO
            Update handling of logging for Notified
        #>
        if (!$token) {
            Write-Error "No Token. Please provide a valide token"
            Break
        }  
    }

    process{
        if ($PSBoundParameters.ContainsKey('Logging')) {
            # Test Log File Path
            $logfilePath = (Test-Path $logFile)
            if (($logFilePath) -ne "True") {
                # Create CSV File and Headers
                $null = New-Item $logfile -ItemType File
                Add-Content $logfile "Date,Name,EmailAddress,DaystoExpire,ExpiresOn,Notified"
            }
        }
        # If Testing Is Enabled - Email Administrator
        Write-Verbose ("User Account: {0}, ExpiresOn: {1}, Days: {2} " -f $ADAccount.Name, $ADAccount.PasswordExpiresOn, $ADAccount.PasswordDaystoExpire)
        if ($TestAddress) {
            $emailAddress = $TestAddress
        }

        # If a user has no email address listed
        elseif ($ADAccount.EmailAddress -eq $null) {
            $emailAddress = $TestAddress
            if (!($emailAddress)) {throw "No email address"}
        }
        else { $emailAddress = $ADAccount.EmailAddress }
        Write-Verbose ("EmailAddress to recieve email: {0}" -f $emailAddress)
        # Email Subject Set Here
        $subject= Set-PWEmailMessagePayload -ADAccount $ADAccount -Subject "Your password will expire {0}"
        $Message = Set-PWEmailMessagePayload -TextToAdd $TextToAdd -ADAccount $ADAccount -Signature $Signature
        $body = Set-PWEmailBody -Subject $subject -Importance 'High' -Message $Message -EmailAddress $emailAddress
        
        #Send the email message
        if (($ADAccount.PasswordDaystoExpire -ge "0") -and ($ADAccount.PasswordDaystoExpire -le $ExpireInDaysThreshold)) {
            $sent = "Yes"
            # If Logging is Enabled Log Details
            if ($PSBoundParameters.ContainsKey('Logging')) {
                Add-Content $logfile "$([datetime]::Today.ToShortDateString()),$($ADAccount.Name),$emailaddress,$($ADAccount.PasswordDaystoExpire),$($ADAccount.PasswordExpiresOn),$sent"
            }
            Try {
                $apiUrl = "$resource/v1.0/users/$SendEmailAccount/sendMail"
                Write-Verbose $apiUrl
                Write-Verbose ("Using Token: {0}"  -f $Token)
                $bodyson = $body | ConvertTo-Json -Depth 20 -Compress
                Write-Verbose ("Payload: {0}" -f $bodyson)
                Invoke-RestMethod -Headers @{Authorization = "Bearer $($token)"} -Uri $apiUrl -Body $bodyson -Method Post -ContentType 'application/json'
            }
            Catch {
                $_
            }
        }
        else{
            $sent = "No"
            # If Logging is Enabled Log Details
            if ($PSBoundParameters.ContainsKey('Logging')) {
                Add-Content $logfile "$([datetime]::Today.ToShortDateString()),$($ADAccount.Name),$emailaddress,$($ADAccount.PasswordDaystoExpire),$($ADAccount.PasswordExpiresOn),$sent"
            }
        }
    }
    
    end{}
}