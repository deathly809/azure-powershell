<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Returns a list of destination shares that the system considers as best candidates for migration.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER ShareName
    Share name.

.PARAMETER FarmId
    Farm Id.

#>
function Get-AzsDestinationShare {
    [CmdletBinding(DefaultParameterSetName = 'Containers_ListDestinationShares')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_ListDestinationShares')]
        [System.String]
        $ResourceGroup,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_ListDestinationShares')]
        [System.String]
        $ShareName,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_ListDestinationShares')]
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


        if ('Containers_ListDestinationShares' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListDestinationSharesWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.Containers.ListDestinationSharesWithHttpMessagesAsync($ResourceGroup, $FarmId, $ShareName)
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

