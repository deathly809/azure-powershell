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
Get-AzsRegionHealth [-Filter <String>] -ResourceGroupName <String> [-Top <Int32>] [-Skip <Int32>]
```

### RegionHealths_Get
```
Get-AzsRegionHealth -Name <String> -ResourceGroupName <String>
```

### ResourceId_RegionHealths_Get
```
Get-AzsRegionHealth -ResourceId <String>
```

### InputObject_RegionHealths_Get
```
Get-AzsRegionHealth -InputObject <RegionHealth>
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
Type: System.String
Parameter Sets: RegionHealths_List
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
The input object of type Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.RegionHealth.

```yaml
Type: Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.RegionHealth
Parameter Sets: InputObject_RegionHealths_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Name of the region

```yaml
Type: System.String
Parameter Sets: RegionHealths_Get
Aliases: Region

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
resourceGroupName.

```yaml
Type: System.String
Parameter Sets: RegionHealths_List, RegionHealths_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
The resource id.

```yaml
Type: System.String
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
Type: System.Int32
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
Type: System.Int32
Parameter Sets: RegionHealths_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.RegionHealth

## NOTES

## RELATED LINKS

