---
external help file: PWExpireNotification-help.xml
Module Name: PWExpireNotification
online version:
schema: 2.0.0
---

# Set-PWEmailMessagePayload

## SYNOPSIS
Creates the full message paylod of to send to Graph API

## SYNTAX

### Message
```
Set-PWEmailMessagePayload -TextToAdd <String> -ADAccount <PSObject> -Signature <PSObject> [<CommonParameters>]
```

### Subject
```
Set-PWEmailMessagePayload -ADAccount <PSObject> -Subject <String> [<CommonParameters>]
```

## DESCRIPTION
Creates the full message paylod of to send to Graph API

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-PWEmailMessagePayload -TextToAdd $TextToAdd -ADAccount $ADAccount -Signature $Signature
```

Prepares the json payload for graph

## PARAMETERS

### -ADAccount
The account that is expiring

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

### -Signature
Signature to be used within the email

```yaml
Type: PSObject
Parameter Sets: Message
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subject
The email subject

```yaml
Type: String
Parameter Sets: Subject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TextToAdd
Any additional text to add to the email body

```yaml
Type: String
Parameter Sets: Message
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
