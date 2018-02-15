---
external help file: Azs.Infrastructureinsights.Admin-help.xml
Module Name: Azs.InfrastructureInsights.Admin
online version: 
schema: 2.0.0
---

# Get-AzsRegionHealth

## SYNOPSIS
Returns alerts at a given location.

## SYNTAX

### RegionHealths_List (Default)
```
Get-AzsRegionHealth [-Filter <String>] -ResourceGroupName <String> [-Top <Int32>] [-Skip <Int32>]
 [<CommonParameters>]
```

### RegionHealths_Get
```
Get-AzsRegionHealth -Name <String> -ResourceGroupName <String> [<CommonParameters>]
```

### ResourceId_RegionHealths_Get
```
Get-AzsRegionHealth -ResourceId <String> [<CommonParameters>]
```

### InputObject_RegionHealths_Get
```
Get-AzsRegionHealth -InputObject <RegionHealth> [<CommonParameters>]
```

## DESCRIPTION
Returns alerts at a given location.

## EXAMPLES

### Example 1
```
PS C:\> Get-AzsRegionHealth -ResourceGroupName System.local

Id                       Type                     Tags                     Name                     Location
--                       ----                     ----                     ----                     --------
/subscriptions/815849... Microsoft.Infrastruct... {}                       local                    local
```

Get all alerts at a location.

### Example 1
```
PS C:\> Get-AzsRegionHealth -ResourceGroupName System.local -Region local

Id                       Type                     Tags                     Name                     Location
--                       ----                     ----                     ----                     --------
/subscriptions/815849... Microsoft.Infrastruct... {}                       local                    local
```

Get an alert by name at a location.

## PARAMETERS

### -Filter
OData filter parameter.

```yaml
Type: String
Parameter Sets: RegionHealths_List
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
The input object of type Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert.```yaml
Type: RegionHealth
Parameter Sets: InputObject_RegionHealths_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Name of the alert.```yaml
Type: String
Parameter Sets: RegionHealths_Get
Aliases: Region

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
resourceGroupName.```yaml
Type: String
Parameter Sets: RegionHealths_List, RegionHealths_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
The resource id.```yaml
Type: String
Parameter Sets: ResourceId_RegionHealths_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Skip
Skip the first N items as specified by the parameter value.

```yaml
Type: Int32
Parameter Sets: RegionHealths_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top
Return the top N items as specified by the parameter value.
Applies after the -Skip parameter.

```yaml
Type: Int32
Parameter Sets: RegionHealths_List
Aliases: 

Required: False
Position: Named
Default value: -1
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

