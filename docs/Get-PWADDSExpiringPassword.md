---
external help file: PWExpireNotification-help.xml
Module Name: PWExpireNotification
online version:
schema: 2.0.0
---

# Get-PWADDSExpiringPassword

## SYNOPSIS
This cmdlet obtains all users within the domain that have a password expiring at some point

## SYNTAX

```
Get-PWADDSExpiringPassword [[-ExpireInDays] <Object>] [[-ADFilter] <ScriptBlock>] [-IncludeAll]
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet obtains all users within the domain that have a password expiring at some point
and omits those users that have an empty passwordlastset attribute

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-PWADDSExpiringPassword
```

Gets all users and their password expiration except if the user is disabled,
,the passwword is already expired, or the password is set to never expire.

### Example 1
```powershell
PS C:\> Get-PWADDSExpiringPassword -IncludeAll
```

Gets all users and their password expiration except if the
password less set is null.  

## PARAMETERS

### -ADFilter
Allows the ability to scope query to a specific location or user attribute

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpireInDays
Filters the output to return only users with passwords that expire less than or equal to the day

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeAll
Enables the return of all users even if the the password never expires.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
