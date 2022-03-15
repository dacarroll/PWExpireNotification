---
external help file: PWExpireNotification-help.xml
Module Name: PWExpireNotification
online version:
schema: 2.0.0
---

# Set-PWEmailBody

## SYNOPSIS
This cmdlet is used to configure the email message body in JSON format for configuring the JSON payload to graph

## SYNTAX

```
Set-PWEmailBody [[-Subject] <String>] [[-Importance] <String>] [[-Message] <String>] [[-EmailAddress] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet is used to configure the email message body in JSON format for configuring the JSON payload to graph

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-PWEmailBody -Subject "Your Password is Expiring in 10 Days" `
                        -Importance "High" `
                        -Message "Please change soon" `
                        -EmailAddress "olduser@mycompany.com"
```

Prepares the message section of the JSON payload to be submitted to Graph for sending the email message

## PARAMETERS

### -EmailAddress
Email address to receive the email

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Importance
Set the Importance of the email: High or Low

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
The message body

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subject
Subject line of the email

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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
