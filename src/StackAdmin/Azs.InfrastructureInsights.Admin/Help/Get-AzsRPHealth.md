---
external help file: Azs.Infrastructureinsights.Admin-help.xml
Module Name: Azs.InfrastructureInsights.Admin
online version: 
schema: 2.0.0
---

# Get-AzsRPHealth

## SYNOPSIS
Returns a list of each service's health.

## SYNTAX

### ServiceHealths_List (Default)
```
Get-AzsRPHealth [-Filter <String>] -Region <String> -ResourceGroupName <String> [-Skip <Int32>] [-Top <Int32>]
```

### ServiceHealths_Get
```
Get-AzsRPHealth -Region <String> -ResourceGroupName <String> -Name <String>
```

### ResourceId_ServiceHealths_Get
```
Get-AzsRPHealth -ResourceId <String>
```

### InputObject_ServiceHealths_Get
```
Get-AzsRPHealth -InputObject <ServiceHealth>
```

## DESCRIPTION
Returns a list of each service's health.

## EXAMPLES

### Example 1
```
PS C:\> Get-AzsRPHealth -Region "local" -ResourceGroup "System.local"

HealthStat Tags       Type       Name       InfraURI   Registrati DisplayNam RoutePrefi Id         Location   ServiceLoc Namespace
e                                                      onId       e          x                                ation
---------- ----       ----       ----       --------   ---------- ---------- ---------- --         --------   ---------- ---------
Healthy    {}         Microso... 1f85c47... /subscr... 1f85c47... Infrast... /subscr... /subscr... local      local
Unknown    {}         Microso... 7eccc6f... /subscr... 7eccc6f... Updates    /subscr... /subscr... local      local
Healthy    {}         Microso... 93b4631... /subscr... 93b4631... Compute    /subscr... /subscr... local      local
Healthy    {}         Microso... a37c646... /subscr... a37c646... Key Vault  /subscr... /subscr... local      local
Unknown    {}         Microso... bb58377... /subscr... bb58377... Region ... /subscr... /subscr... local      local
Healthy    {}         Microso... bcb6ae5... /subscr... bcb6ae5... Storage    /subscr... /subscr... local      local
Critical   {}         Microso... e56bc7b... /subscr... e56bc7b... Capacity   /subscr... /subscr... local      local
Healthy    {}         Microso... ead797b... /subscr... ead797b... Network    /subscr... /subscr... local      local
```

Returns all resource provider's health in a region.

### Example 2
```
PS C:\> Get-AzsRPHealth -ResourceGroupName System.local -Region local -Name 1f85c473-cbe1-41b0-9ffe-ff6f138dbbef

HealthStat Tags       Type       Name       InfraURI   Registrati DisplayNam RoutePrefi Id         Location   ServiceLoc Namespace
e                                                      onId       e          x                                ation
---------- ----       ----       ----       --------   ---------- ---------- ---------- --         --------   ---------- ---------
Healthy    {}         Microso... 1f85c47... /subscr... 1f85c47... Infrast... /subscr... /subscr... local      local
```

Returns the specified resource provider's health.

## PARAMETERS

### -Filter
OData filter parameter.

```yaml
Type: System.String
Parameter Sets: ServiceHealths_List
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
The input object of type Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ServiceHealth.

```yaml
Type: Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ServiceHealth
Parameter Sets: InputObject_ServiceHealths_Get
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Service Health name.

```yaml
Type: System.String
Parameter Sets: ServiceHealths_Get
Aliases: ServiceHealth

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Region
Name of the region

```yaml
Type: System.String
Parameter Sets: ServiceHealths_List, ServiceHealths_Get
Aliases: 

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
Parameter Sets: ServiceHealths_List, ServiceHealths_Get
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
Parameter Sets: ResourceId_ServiceHealths_Get
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
Parameter Sets: ServiceHealths_List
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
Parameter Sets: ServiceHealths_List
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.ServiceHealth

## NOTES

## RELATED LINKS

