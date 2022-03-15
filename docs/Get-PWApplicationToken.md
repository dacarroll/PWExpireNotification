---
external help file: PWExpireNotification-help.xml
Module Name: PWExpireNotification
online version:
schema: 2.0.0
---

# Get-PWApplicationToken

## SYNOPSIS
Obtains an Application token using a client secret

## SYNTAX

```
Get-PWApplicationToken [-clientID] <String> [-clientSecret] <String> [-Resource] <String>
 [-tenantName] <String> [<CommonParameters>]
```

## DESCRIPTION
Intended to be used to obtain an token for an application that has Mail.Send permissions within Graph.

## EXAMPLES

### Example 1
```powershell
PS C:\> $param = @{
    clientID     = $clientID
    clientSecret = $sec
    resource     = $resource
    tenantName    = $tenantName
}
$token = Get-PWApplicationToken @param
```

Providing the client ID, secret, graph resource, and tenantname, returns an OAuth token for the specified application

## PARAMETERS

### -Resource
Used to identify the graph resource where the token will be used.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: https://graph.microsoft.com, https://graph.microsoft.us, https://dod-graph.microsoft.us

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -clientID
Application ID of the AAD application

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -clientSecret
Client secret of the application

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -tenantName
Full TenantName such as mydomain.onmicrosoft.com

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
