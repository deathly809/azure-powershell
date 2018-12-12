
# Table of Contents

1. [Summary](#summary)
2. [Breaking changes in Fabric module](#Breaking-changes-in-fabric-module)

## Summary

The module version 1.6.0 of AzureStack brings in a few breaking changes. Please note that there are no changes in the AzureRM version of the module specific to Azure Stack.

## Breaking changes in Fabric module

**New Cmdlets**
 The following cmdlets have been introduced and are supported only in 1811 and onward
    * Get-AzsDrive
    * Get-AzsVolume

**Modified Cmdlets**
Get-AzsStorageSystem requires a new parameter

* ScaleUnit - This value can be retrieved using the Get-AzsScaleUnitNode cmdlet

**Deprecated Cmdlets**
We have deprecated a single cmdlet and provided an alias.

* ```Get-AzsInfrastructureVolume``` Has a new required parameter ScaleUnit which can be retrieved using the Get-AzsScaleUnitNode cmdlet
