<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.

Code generated by Microsoft (R) PSSwagger
Changes may cause incorrect behavior and will be lost if the code is regenerated.
#>

<#
.SYNOPSIS
    Create a Virtual Machine Extension Image.

.DESCRIPTION
    Create a Virtual Machine Extension Image.

.PARAMETER ProvisioningState
    Provisioning state of extension.

.PARAMETER Id
    ID of the resource.

.PARAMETER Type
    Type of Resource.

.PARAMETER VmScaleSetEnabled
    Value indicating whether the extension is enabled for virtual machine scale set support.

.PARAMETER ResourceId
    The resource id.

.PARAMETER VmOsType
    Target virtual machine operating system type necessary for deploying the extension handler.

.PARAMETER SupportMultipleExtensions
    True if supports multiple extensions.

.PARAMETER LocationName
    Location of the resource.

.PARAMETER IsSystemExtension
    Indicates if the extension is for the system.

.PARAMETER ComputeRole
    Compute role

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Compute.Admin.Models.VMExtension.

.PARAMETER SourceBlob
    URI to Azure or AzureStack blob.

.PARAMETER Publisher
    Name of the publisher.

.PARAMETER Name
    Name of the resource.

.PARAMETER Name
    The version of the resource.

.PARAMETER Location
    Location of the resource.

#>
function New-AzsVMExtension
{
    [OutputType([Microsoft.AzureStack.Management.Compute.Admin.Models.VMExtension])]
    [CmdletBinding(DefaultParameterSetName='VMExtensions_Create')]
    param(    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_VMExtensions_Create')]
        [Microsoft.AzureStack.Management.Compute.Admin.Models.ProvisioningState]
        $ProvisioningState,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_VMExtensions_Create')]
        [string]
        $Id,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_VMExtensions_Create')]
        [string]
        $Type,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_VMExtensions_Create')]
        [switch]
        $VmScaleSetEnabled,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_VMExtensions_Create')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_VMExtensions_Create')]
        [Microsoft.AzureStack.Management.Compute.Admin.Models.OsType]
        $VmOsType,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_VMExtensions_Create')]
        [switch]
        $SupportMultipleExtensions,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'VMExtensions_Create')]
        [System.String]
        $LocationName,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_VMExtensions_Create')]
        [switch]
        $IsSystemExtension,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_VMExtensions_Create')]
        [string]
        $ComputeRole,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_VMExtensions_Create')]
        [Microsoft.AzureStack.Management.Compute.Admin.Models.VMExtension]
        $InputObject,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_VMExtensions_Create')]
        [Microsoft.AzureStack.Management.Compute.Admin.Models.AzureBlob]
        $SourceBlob,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'VMExtensions_Create')]
        [System.String]
        $Publisher,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_VMExtensions_Create')]
        [string]
        $Name,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'VMExtensions_Create')]
        [Alias('Version')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_VMExtensions_Create')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_VMExtensions_Create')]
        [string]
        $Location
    )

    Begin 
    {
	    Initialize-PSSwaggerDependencies -Azure
        $tracerObject = $null
        if (('continue' -eq $DebugPreference) -or ('inquire' -eq $DebugPreference)) {
            $oldDebugPreference = $global:DebugPreference
			$global:DebugPreference = "continue"
            $tracerObject = New-PSSwaggerClientTracing
            Register-PSSwaggerClientTracing -TracerObject $tracerObject
        }
	}

    Process {
    
    $ErrorActionPreference = 'Stop'

    $NewServiceClient_params = @{
        FullClientTypeName = 'Microsoft.AzureStack.Management.Compute.Admin.ComputeAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable
     
    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $ComputeAdminClient = New-ServiceClient @NewServiceClient_params

        
    $flattenedParameters = @('ProvisioningState', 'SourceBlob', 'Id', 'Type', 'ComputeRole', 'VmOsType', 'Name', 'Location', 'SupportMultipleExtensions', 'IsSystemExtension', 'VmScaleSetEnabled')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }
    $Extension = New-VMExtensionObject @utilityCmdParams

 
    $Version = $Name

 
    if('InputObject_VMExtensions_Create' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_VMExtensions_Create' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Compute.Admin/locations/{locationName}/artifactTypes/VMExtension/publishers/{publisher}/types/{type}/versions/{version}'
        }

        if('ResourceId_VMExtensions_Create' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $locationName = $ArmResourceIdParameterValues['locationName']

        $publisher = $ArmResourceIdParameterValues['publisher']

        $type = $ArmResourceIdParameterValues['type']

        $version = $ArmResourceIdParameterValues['version']
    }


    if ('VMExtensions_Create' -eq $PsCmdlet.ParameterSetName -or 'InputObject_VMExtensions_Create' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_VMExtensions_Create' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateWithHttpMessagesAsync on $ComputeAdminClient.'
        $TaskResult = $ComputeAdminClient.VMExtensions.CreateWithHttpMessagesAsync($LocationName, $Publisher, $Type, $Version, $Extension)
    } else {
        Write-Verbose -Message 'Failed to map parameter set to operation method.'
        throw 'Module failed to find operation to execute.'
    }

    if ($TaskResult) {
        $GetTaskResult_params = @{
            TaskResult = $TaskResult
        }
            
        Get-TaskResult @GetTaskResult_params
        
    }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}

