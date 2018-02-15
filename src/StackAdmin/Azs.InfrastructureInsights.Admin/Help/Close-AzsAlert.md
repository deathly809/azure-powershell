---
external help file: Azs.Infrastructureinsights.Admin-help.xml
Module Name: Azs.InfrastructureInsights.Admin
online version: 
schema: 2.0.0
---

# Close-AzsAlert

## SYNOPSIS
Close an alert.

## SYNTAX

### InputObject_Alerts_Close
```
Close-AzsAlert -InputObject <Alert> [-User <String>] [<CommonParameters>]
```

### ResourceId_Alerts_Close
```
Close-AzsAlert [-User <String>] -ResourceId <String> [<CommonParameters>]
```

## DESCRIPTION
Close an alert.

## EXAMPLES

### Example 1
```
PS C:\> Close-AzsAlert -InputObject $MyAlert

Fault Tags  Close Close Name  Resou Sever Creat LastU Resou Type  Remed Impac Title Impac Alert Descr Id    State Locat Fault AlertId
TypeI       dTime dByUs       rceRe ity   edTim pdate rcePr       iatio tedRe       tedRe Prope iptio             ion   Id
d           stamp erAli       gistr       estam dTime ovide       n     sourc       sourc rties n
                  as          ation       p     stamp rRegi             eId         eDisp
                              Id                      strat                         layNa
                                                      ionId                         me
----- ----  ----- ----- ----  ----- ----- ----- ----- ----- ----  ----- ----- ----- ----- ----- ----- --    ----- ----- ----- -------
Se... {}    02...       06...       Wa... 02... 02... e5... Mi... {S... /s... In... Ke... {[... {S... /s... Cl... local Se... 060a41e5-0992-45a1-a472-5046329c1908
```


### Example 1
```
PS C:\> Close-AzsAlert -ResourceId "/subscriptions/44444444-3333-2222-1111-000000000000/resourceGroups/System.local/providers/Microsoft.InfrastructureInsights.Admin/regionHealths/local/alerts/060a41e5-0992-45a1-a472-5046329c1908"

Fault Tags  Close Close Name  Resou Sever Creat LastU Resou Type  Remed Impac Title Impac Alert Descr Id    State Locat Fault AlertId
TypeI       dTime dByUs       rceRe ity   edTim pdate rcePr       iatio tedRe       tedRe Prope iptio             ion   Id
d           stamp erAli       gistr       estam dTime ovide       n     sourc       sourc rties n
                  as          ation       p     stamp rRegi             eId         eDisp
                              Id                      strat                         layNa
                                                      ionId                         me
----- ----  ----- ----- ----  ----- ----- ----- ----- ----- ----  ----- ----- ----- ----- ----- ----- --    ----- ----- ----- -------
Se... {}    02...       06...       Wa... 02... 02... e5... Mi... {S... /s... In... Ke... {[... {S... /s... Cl... local Se... 060a41e5-0992-45a1-a472-5046329c1908
```

Close an alert.

## PARAMETERS

### -InputObject
The input object of type Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert.```yaml
Type: Alert
Parameter Sets: InputObject_Alerts_Close
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ResourceId
The resource id.```yaml
Type: String
Parameter Sets: ResourceId_Alerts_Close
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -User
The username used to perform the operation.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert

## NOTES

## RELATED LINKS

