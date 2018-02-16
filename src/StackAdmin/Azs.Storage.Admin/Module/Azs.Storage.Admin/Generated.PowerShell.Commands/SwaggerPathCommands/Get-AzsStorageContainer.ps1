<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Returns the list of containers which can be migrated in the specified share.

.PARAMETER StartIndex
    The start index of get containers.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER Intent
    The container migration intent.

.PARAMETER ShareName
    Share name.

.PARAMETER FarmId
    Farm Id.

.PARAMETER MaxCount
    The max count of containers.

#>
function Get-AzsStorageContainer {
    [CmdletBinding(DefaultParameterSetName = 'Containers_List')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_List')]
        [System.Int32]
        $StartIndex,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_List')]
        [System.String]
        $ResourceGroup,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_List')]
        [System.String]
        $Intent,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_List')]
        [System.String]
        $ShareName,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_List')]
        [System.String]
        $FarmId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_List')]
        [System.Int32]
        $MaxCount
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


        if ('Containers_List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.Containers.ListWithHttpMessagesAsync($ResourceGroup, $FarmId, $ShareName, $Intent, $MaxCount, $StartIndex)
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

