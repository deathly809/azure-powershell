<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Delete an existing quota

.PARAMETER ResourceId
    The resource id.

.PARAMETER Location
    Resource location.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota.

.PARAMETER Name
    The name of the storage quota.

#>
function Remove-AzsStorageQuota {
    [CmdletBinding(DefaultParameterSetName = 'StorageQuotas_Delete')]
    param(    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_StorageQuotas_Delete')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'StorageQuotas_Delete')]
        [System.String]
        $Location,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_StorageQuotas_Delete')]
        [Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota]
        $InputObject,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'StorageQuotas_Delete')]
        [Alias('QuotaName')]
        [System.String]
        $Name
    )

    Begin {
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
     
        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $StorageAdminClient = New-ServiceClient @NewServiceClient_params

        $QuotaName = $Name

 
        if ('InputObject_StorageQuotas_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_StorageQuotas_Delete' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Storage.Admin/locations/{location}/quotas/{quotaName}'
            }

            if ('ResourceId_StorageQuotas_Delete' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            }
            else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $location = $ArmResourceIdParameterValues['location']

            $quotaName = $ArmResourceIdParameterValues['quotaName']
        }


        if ('StorageQuotas_Delete' -eq $PsCmdlet.ParameterSetName -or 'InputObject_StorageQuotas_Delete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_StorageQuotas_Delete' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation DeleteWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageQuotas.DeleteWithHttpMessagesAsync($Location, $QuotaName)
        }
        else {
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

