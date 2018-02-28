<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

#
# Module manifest for module 'Azs.Compute.Admin'
#
# Generated by: Microsoft
#
# Generated on: 2/23/2018
#

@{

# Script module or binary module file associated with this manifest.
RootModule        = 'Azs.Compute.Admin.psm1'

# Version number of this module.
ModuleVersion     = '0.1.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID              = 'e662cef1-a477-40a2-ab9f-06e8de7cc423'

# Author of this module
Author            = 'Microsoft'

# Company or vendor of this module
CompanyName       = 'Microsoft'

# Copyright statement for this module
Copyright         = '(c) 2018 Microsoft. All rights reserved.'

# Description of the functionality provided by this module
Description       = 'Compute Admin Client'

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
FormatsToProcess  = '.\Generated.PowerShell.Commands\FormatFiles\AzureBlob.ps1xml',
'.\Generated.PowerShell.Commands\FormatFiles\DataDisk.ps1xml',
'.\Generated.PowerShell.Commands\FormatFiles\ImageDetails.ps1xml',
'.\Generated.PowerShell.Commands\FormatFiles\OsDisk.ps1xml',
'.\Generated.PowerShell.Commands\FormatFiles\PlatformImage.ps1xml',
'.\Generated.PowerShell.Commands\FormatFiles\Quota.ps1xml',
'.\Generated.PowerShell.Commands\FormatFiles\QuotaList.ps1xml',
'.\Generated.PowerShell.Commands\FormatFiles\Resource.ps1xml',
'.\Generated.PowerShell.Commands\FormatFiles\VMExtension.ps1xml',
'.\Generated.PowerShell.Commands\FormatFiles\VMExtensionParameters.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('PSSwaggerUtility')

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Get-AzsComputeVMExtension', 'Remove-AzsComputeQuota',
'New-AzsComputeQuota', 'New-AzsComputePlatformImage',
'Remove-AzsComputeVMExtension',
'Get-AzsComputePlatformImage', 'Get-AzsComputeQuota',
'New-AzsComputeVMExtension', 'Set-AzsComputeQuota',
'Remove-AzsComputePlatformImage', 'New-AzureBlobObject',
'New-DataDiskObject', 'New-ImageDetailsObject',
'New-OsDiskObject'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport   = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport   = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData       = @{

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


