---
external help file: PWExpireNotification-help.xml
Module Name: PWExpireNotification
online version:
schema: 2.0.0
---

# Send-PWExpiringMailMessage

## SYNOPSIS
Used to send password expiration notification of ADDS Users

## SYNTAX

```
Send-PWExpiringMailMessage -Resource <String> -SendEmailAccount <String> -Token <String>
 [-TestAddress <String>] -ADAccount <PSObject> -Signature <String> -TextToAdd <String>
 [-ExpireInDaysThreshold <Int32>] [-Logging] [-LogFile <String>] [<CommonParameters>]
```

## DESCRIPTION
Used to send password expiration notification of ADDS Users

## EXAMPLES

### Example 1
```powershell
PS C:\>$params = @{
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
```

This command takes the input from the $params hashtable and then sends an email to the test address versus the configured user. This would be used in a test scenario. Prior to live implemenation. 

## PARAMETERS

### -ADAccount
The ADUser account object

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpireInDaysThreshold
The threshold for limiting at what time a user would be notified based on when their password expires.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFile
If you want to log each run of this function this will enable logging and display what users were notified placing the logfile in the specified path. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Logging
Enable logging and output the logfile to the current working directory.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Resource
The graph resource that will be used

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: https://graph.microsoft.com, https://graph.microsoft.us, https://dod-graph.microsoft.us

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SendEmailAccount
The account that will be used to send the mail message. e.g. Shared O365 Mailbox

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Signature
The signature as a string that you would like within your email body.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestAddress
Used for testing, all email messages will go to this address versus the end user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TextToAdd
A free form string that will be within the email message body below the default line containing the number of days remaining before their password expires. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token
The token that will be used to send the message

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
