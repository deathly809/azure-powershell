<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

#
# Module manifest for module 'Azs.Fabric.Admin'
#
# Generated by: jerobins
#
# Generated on: 2/21/2018
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'Azs.Fabric.Admin.psm1'

# Version number of this module.
ModuleVersion = '0.1.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '6ad9b0a0-a9c0-490c-83d3-02eeb307d1ad'

# Author of this module
Author = 'jerobins'

# Company or vendor of this module
CompanyName = 'Unknown'

# Copyright statement for this module
Copyright = '(c) 2018 jerobins. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Fabric Admin Client'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess =
               '.\Generated.PowerShell.Commands\FormatFiles\BareMetalNodeDescription.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\EdgeGateway.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\EdgeGatewayList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\EdgeGatewayPool.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\EdgeGatewayPoolList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\FabricLocation.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\FabricLocationList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\FileShare.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\InfraRole.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\InfraRoleInstance.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\InfraRoleInstanceList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\InfraRoleInstanceSize.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\InfraRoleList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\IpPool.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\IpPoolList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\LogicalNetwork.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\LogicalNetworkList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\LogicalSubnet.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\LogicalSubnetList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\MacAddressPool.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\MacAddressPoolList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\ProvisioningState.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\Resource.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\ScaleOutScaleUnitParameters.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\ScaleOutScaleUnitParametersList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\ScaleUnit.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\ScaleUnitCapacity.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\ScaleUnitList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\ScaleUnitNode.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\ScaleUnitNodeList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\SlbMuxInstance.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\SlbMuxInstanceList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\StoragePool.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\StoragePoolList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\StorageSystem.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\StorageSystemList.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\Volume.ps1xml',
               '.\Generated.PowerShell.Commands\FormatFiles\VolumeList.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('PSSwaggerUtility')

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Restart-AzsInfrastructureRoleInstance', 'Get-AzsStorageSystem',
               'Add-AzsScaleUnitNode', 'Stop-AzsScaleUnitNode',
               'Get-AzsScaleUnitNode', 'Disable-AzsScaleUnitNode',
               'Get-AzsLogicalNetwork', 'Get-AzsInfrastructureShare',
               'Get-AzsSlbMuxInstance', 'Get-AzsScaleUnit', 'New-AzsIpPool',
               'Start-AzsInfrastructureRoleInstance','Get-AzsMacAddressPool',
               'Get-AzsEdgeGatewayPool', 'Submit-AzsScaleUnitNodeShutdown',
               'Get-AzsInfrastructureVolume', 'Enable-AzsScaleUnitNode',
               'Get-AzsInfrastructureRole', 'Get-AzsIpPool', 'Get-AzsLogicalSubnet',
               'Get-AzsEdgeGateway', 'Get-AzsInfrastructureLocation',
               'Set-AzsIpPool', 'Get-AzsStoragePool', 'Disable-AzsInfrastructureRoleInstance',
               'Start-AzsScaleUnitNode', 'Get-AzsInfrastructureRoleInstance',
               'Repair-AzsScaleUnitNode', 'Stop-AzsInfrastructureRoleInstance',
               'New-ScaleOutScaleUnitParametersObject'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        # ProjectUri = ''

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}


