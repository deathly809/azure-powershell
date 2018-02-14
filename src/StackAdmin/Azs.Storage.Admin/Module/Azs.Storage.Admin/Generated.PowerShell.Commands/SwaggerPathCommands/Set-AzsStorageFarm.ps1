<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Update an existing storage farm.

.PARAMETER Id
    Resource ID.

.PARAMETER Type
    Resource type.

.PARAMETER SettingAccessString
    Setting access string.

.PARAMETER Tags
    Resource tags.

.PARAMETER Name
    Resource Name.

.PARAMETER Name
    Farm Id.

.PARAMETER Location
    Resource location.

.PARAMETER ResourceId
    The resource id.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.Farm.

.PARAMETER ResourceGroupName
    Resource group name.

#>
function Set-AzsStorageFarm
{
    [OutputType([Microsoft.AzureStack.Management.Storage.Admin.Models.Farm])]
    [CmdletBinding(DefaultParameterSetName='Farms_Update')]
    param(    
        [Parameter(Mandatory = $false, ParameterSetName = 'Farms_Update')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Farms_Update')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Farms_Update')]
        [string]
        $Id,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Farms_Update')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Farms_Update')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Farms_Update')]
        [string]
        $Type,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Farms_Update')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Farms_Update')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Farms_Update')]
        [string]
        $SettingAccessString,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Farms_Update')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Farms_Update')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Farms_Update')]
        [System.Collections.Generic.Dictionary[[string],[string]]]
        $Tags,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'Farms_Update')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Farms_Update')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Farms_Update')]
        [string]
        $Name,
        
        [Parameter(Mandatory = $false, ParameterSetName = 'Farms_Update')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Farms_Update')]
        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Farms_Update')]
        [string]
        $Location,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Farms_Update')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Farms_Update')]
        [Microsoft.AzureStack.Management.Storage.Admin.Models.Farm]
        $InputObject,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Farms_Update')]
        [System.String]
        $ResourceGroupName
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.Storage.Admin.StorageAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable
     
    $GlobalParameterHashtable['Parameters'] = $null
    if($PSBoundParameters.ContainsKey('Parameters')) {
        $GlobalParameterHashtable['Parameters'] = $PSBoundParameters['Parameters']
    }
     
    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }
     
    $GlobalParameterHashtable['Parameters'] = $null
    if($PSBoundParameters.ContainsKey('Parameters')) {
        $GlobalParameterHashtable['Parameters'] = $PSBoundParameters['Parameters']
    }
     
    $GlobalParameterHashtable['Parameters'] = $null
    if($PSBoundParameters.ContainsKey('Parameters')) {
        $GlobalParameterHashtable['Parameters'] = $PSBoundParameters['Parameters']
    }

    $StorageAdminClient = New-ServiceClient @NewServiceClient_params

        
    $flattenedParameters = @('Id', 'Type', 'SettingAccessString', 'Tags', 'Name', 'Location')
    $utilityCmdParams = @{}
    $flattenedParameters | ForEach-Object {
        if($PSBoundParameters.ContainsKey($_)) {
            $utilityCmdParams[$_] = $PSBoundParameters[$_]
        }
    }
    $Parameters = New-FarmCreationPropertiesObject @utilityCmdParams

 
    $FarmId = $Name

 
    if('InputObject_Farms_Update' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Farms_Update' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Storage.Admin/farms/{farmId}'
        }

        if('ResourceId_Farms_Update' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $farmId = $ArmResourceIdParameterValues['farmId']
    }


    if ('Farms_Update' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Farms_Update' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Farms_Update' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation UpdateWithHttpMessagesAsync on $StorageAdminClient.'
        $TaskResult = $StorageAdminClient.Farms.UpdateWithHttpMessagesAsync($ResourceGroupName, $FarmId)
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

