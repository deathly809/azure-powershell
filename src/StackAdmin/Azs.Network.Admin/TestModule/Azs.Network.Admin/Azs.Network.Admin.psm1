<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

Microsoft.PowerShell.Core\Set-StrictMode -Version Latest

# If the user supplied -Prefix to Import-Module, that applies to the nested module as well
# Force import the nested module again without -Prefix
if (-not (Get-Command Get-OperatingSystemInfo -Module PSSwaggerUtility -ErrorAction Ignore)) {
    Import-Module PSSwaggerUtility -Force
}

if ((Get-OperatingSystemInfo).IsCore) {
    . (Join-Path -Path $PSScriptRoot "Test-CoreRequirements.ps1")
    $clr = 'coreclr'
}
else {
    . (Join-Path -Path $PSScriptRoot "Test-FullRequirements.ps1")
    $clr = 'fullclr'
}

$ClrPath = Join-Path -Path $PSScriptRoot -ChildPath 'ref' | Join-Path -ChildPath $clr

$allDllsPath = Join-Path -Path $ClrPath -ChildPath '*.dll'
if (Test-Path -Path $ClrPath -PathType Container) {
    Get-ChildItem -Path $allDllsPath -File | ForEach-Object { Add-Type -Path $_.FullName -ErrorAction SilentlyContinue }
}

. (Join-Path -Path $PSScriptRoot -ChildPath 'New-ServiceClient.ps1')
. (Join-Path -Path $PSScriptRoot -ChildPath 'Get-TaskResult.ps1')
. (Join-Path -Path $PSScriptRoot -ChildPath 'Get-ApplicableFilters.ps1')
. (Join-Path -Path $PSScriptRoot -ChildPath 'Test-FilteredResult.ps1')
. (Join-Path -Path $PSScriptRoot -ChildPath 'Get-ArmResourceIdParameterValue.ps1')
$allPs1FilesPath = Join-Path -Path $PSScriptRoot -ChildPath 'Generated.PowerShell.Commands' | Join-Path -ChildPath '*.ps1'
Get-ChildItem -Path $allPs1FilesPath -Recurse -File | ForEach-Object { . $_.FullName}