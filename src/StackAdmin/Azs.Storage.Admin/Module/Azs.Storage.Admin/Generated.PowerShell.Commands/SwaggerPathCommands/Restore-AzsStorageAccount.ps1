<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Undelete a deleted storage account.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER ResourceId
    The resource id.

.PARAMETER FarmId
    Farm Id.

.PARAMETER Name
    Internal storage account ID, which is not visible to tenant.

#>
function Restore-AzsStorageAccount {
    [CmdletBinding(DefaultParameterSetName = 'StorageAccounts_Undelete')]
    param(    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_StorageAccounts_Undelete')]
        [Microsoft.AzureStack.Management.Storage.Admin.Models.StorageAccount]
        $InputObject,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'StorageAccounts_Undelete')]
        [System.String]
        $ResourceGroup,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_StorageAccounts_Undelete')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'StorageAccounts_Undelete')]
        [System.String]
        $FarmId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'StorageAccounts_Undelete')]
        [Alias('AccountId')]
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

        $AccountId = $Name

 
        if ('InputObject_StorageAccounts_Undelete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_StorageAccounts_Undelete' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Storage.Admin/farms/{farmId}/storageaccounts/{accountId}'
            }

            if ('ResourceId_StorageAccounts_Undelete' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            }
            else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $ResourceGroup = $ArmResourceIdParameterValues['resourceGroupName']

            $farmId = $ArmResourceIdParameterValues['farmId']

            $accountId = $ArmResourceIdParameterValues['accountId']
        }


        if ('StorageAccounts_Undelete' -eq $PsCmdlet.ParameterSetName -or 'InputObject_StorageAccounts_Undelete' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_StorageAccounts_Undelete' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation UndeleteWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageAccounts.UndeleteWithHttpMessagesAsync($ResourceGroup, $FarmId, $AccountId)
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

