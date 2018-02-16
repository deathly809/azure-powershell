<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Returns the state of the garbage collection job.

.PARAMETER OperationId
    Operation Id.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER FarmId
    Farm Id.

#>
function Get-AzsStorageFarmMetricDefinition {
    [CmdletBinding(DefaultParameterSetName = 'Farms_GetGarbageCollectionState')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'Farms_GetGarbageCollectionState')]
        [System.String]
        $OperationId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Farms_GetGarbageCollectionState')]
        [System.String]
        $ResourceGroup,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Farms_GetGarbageCollectionState')]
        [System.String]
        $FarmId
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


        if ('Farms_GetGarbageCollectionState' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetGarbageCollectionStateWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.Farms.GetGarbageCollectionStateWithHttpMessagesAsync($ResourceGroup, $FarmId, $OperationId)
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

