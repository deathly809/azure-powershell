---
Module Name: Azs.Fabric.Admin
Module Guid: 5e04dc01-069b-4fad-a590-ccff2c6e20b5
Download Help Link: 
Help Version: 0.1.0
Locale: en-US
---

# Azs.Fabric.Admin Module
## Description
Allows AzureStack administrators view and manage their infrastructure.

## Azs.Fabric.Admin Cmdlets
### [Add-AzsScaleUnitNode](Add-AzsScaleUnitNode.md)
Add a new scale unit.

### [Suspend-AzsInfrastructureRoleInstance](Suspend-AzsInfrastructureRoleInstance.md)
Shut down an infrastructure role instance.  On failure an exception is thrown.

### [Disable-AzsScaleUnitNode](Disable-AzsScaleUnitNode.md)
Start maintenance mode for a scale unit node.  This begins the process of moving all resources off the node.

### [Enable-AzsScaleUnitNode](Enable-AzsScaleUnitNode.md)
Stop maintenance mode for a scale unit node.

### [Get-AzsEdgeGateway](Get-AzsEdgeGateway.md)
Get edge gateways.

### [Get-AzsEdgeGatewayPool](Get-AzsEdgeGatewayPool.md)
Get edge gateway pools.

### [Get-AzsInfrastructureLocation](Get-AzsInfrastructureLocation.md)
Get a list of all fabric locations.

### [Get-AzsInfrastructureRole](Get-AzsInfrastructureRole.md)
Get infrastructure roles.

### [Get-AzsInfrastructureRoleInstance](Get-AzsInfrastructureRoleInstance.md)
Get a list of infrastructure role instances.

### [Get-AzsInfrastructureShare](Get-AzsInfrastructureShare.md)
Get file shares.

### [Get-AzsInfrastructureVolume](Get-AzsInfrastructureVolume.md)
Get volumes at a location.

### [Get-AzsIpPool](Get-AzsIpPool.md)
Get infrastructure ip pools.

### [Get-AzsLogicalNetwork](Get-AzsLogicalNetwork.md)
Get logical networks from a given location.

### [Get-AzsLogicalSubnet](Get-AzsLogicalSubnet.md)
Get logical subnets under a logical network at a specific location.

### [Get-AzsMacAddressPool](Get-AzsMacAddressPool.md)
Get MAC address pools at a certain location.

### [Get-AzsScaleUnit](Get-AzsScaleUnit.md)
Get scale units.

### [Get-AzsScaleUnitNode](Get-AzsScaleUnitNode.md)
Get scale unit nodes at a certain location.

### [Get-AzsSlbMuxInstance](Get-AzsSlbMuxInstance.md)
Get software load balanacer multiplexer instances at a certain location.

### [Get-AzsStoragePool](Get-AzsStoragePool.md)
Get storage pools at a location.

### [Get-AzsStorageSystem](Get-AzsStorageSystem.md)
Get storage subsystems given a location.

### [New-AzsIpPool](New-AzsIpPool.md)
Create an IP pool.
Once created an IP pool cannot be deleted.

### [New-AzsScaleUnitNodeObject](New-AzsScaleUnitNodeObject.md)
Input data that allows for adding a scale unit node.

### [Repair-AzsScaleUnitNode](Repair-AzsScaleUnitNode.md)
Repairs a node of the cluster.

### [Restart-AzsInfrastructureRole](Restart-AzsInfrastructureRole.md)
Restarts the requestd infrastructure role.

### [Restart-AzsInfrastructureRoleInstance](Restart-AzsInfrastructureRoleInstance.md)
Reboot an infrastructure role instance.  On failure an exception is thrown.

### [Start-AzsInfrastructureRoleInstance](Start-AzsInfrastructureRoleInstance.md)
Power on an infrastructure role instance. On failure an exception is thrown.

### [Start-AzsScaleUnitNode](Start-AzsScaleUnitNode.md)
Power on a scale unit node.

### [Stop-AzsInfrastructureRoleInstance](Stop-AzsInfrastructureRoleInstance.md)
Power off an infrastructure role instance. On failure an exception is thrown.

### [Stop-AzsScaleUnitNode](Stop-AzsScaleUnitNode.md)
Power off a scale unit node.  This will turn off your physical machine and should be used with extreme caution.

### [Submit-AzsScaleUnitNodeShutdown](Submit-AzsScaleUnitNodeShutdown.md)
Shutdown a scale unit node.
