---
external help file: Azs.Infrastructureinsights.Admin-help.xml
Module Name: Azs.InfrastructureInsights.Admin
online version: 
schema: 2.0.0
---

# Get-AzsRegionHealth

## SYNOPSIS
Returns a list of region's health status.

## SYNTAX

### RegionHealths_List (Default)
```
Get-AzsRegionHealth [-Filter <String>] [-ResourceGroupName <String>] [-Top <Int32>] [-Skip <Int32>]
 [<CommonParameters>]
```

### RegionHealths_Get
```
Get-AzsRegionHealth [-Location <String>] [-ResourceGroupName <String>] [<CommonParameters>]
```

### ResourceId_RegionHealths_Get
```
Get-AzsRegionHealth -ResourceId <String> [<CommonParameters>]
```

## DESCRIPTION
Returns a list of region's health status.

## EXAMPLES

### Example 1
```
PS C:\> Get-AzsRegionHealth -ResourceGroupName System.local

Id                       Type                     Tags                     Name                     Location
--                       ----                     ----                     ----                     --------
/subscriptions/815849... Microsoft.Infrastruct... {}                       local                    local
```

Returns all region healths.

### Example 2
```
PS C:\> Get-AzsRegionHealth -ResourceGroupName System.local -Region local

Id                       Type                     Tags                     Name                     Location
--                       ----                     ----                     ----                     --------
/subscriptions/815849... Microsoft.Infrastruct... {}                       local                    local
```

Return the specified region health.

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

### -Location
Name of the region```yaml
Type: String
Parameter Sets: RegionHealths_Get
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
resourceGroupName.

```yaml
Type: String
Parameter Sets: RegionHealths_List, RegionHealths_Get
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
The resource id.

```yaml
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

### Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.RegionHealth

## NOTES

## RELATED LINKS
