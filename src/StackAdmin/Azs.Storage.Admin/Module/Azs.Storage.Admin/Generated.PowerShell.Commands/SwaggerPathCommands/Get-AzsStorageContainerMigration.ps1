<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Returns the status of a container migration job.

.PARAMETER Name
    Operation Id.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER ResourceId
    The resource id.

.PARAMETER FarmId
    Farm Id.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.MigrationResult.

#>
function Get-AzsStorageContainerMigration {
    [OutputType([Microsoft.AzureStack.Management.Storage.Admin.Models.MigrationResult])]
    [CmdletBinding(DefaultParameterSetName = 'Containers_MigrationStatus')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_MigrationStatus')]
        [Alias('OperationId')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_MigrationStatus')]
        [System.String]
        $ResourceGroup,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Containers_MigrationStatus')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_MigrationStatus')]
        [System.String]
        $FarmId,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Containers_MigrationStatus')]
        [Microsoft.AzureStack.Management.Storage.Admin.Models.MigrationResult]
        $InputObject
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

        $OperationId = $Name

 
        if ('InputObject_Containers_MigrationStatus' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Containers_MigrationStatus' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Storage.Admin/farms/{farmId}/shares/operationresults/{operationId}'
            }

            if ('ResourceId_Containers_MigrationStatus' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            }
            else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $ResourceGroup = $ArmResourceIdParameterValues['resourceGroupName']

            $farmId = $ArmResourceIdParameterValues['farmId']

            $operationId = $ArmResourceIdParameterValues['operationId']
        }


        if ('Containers_MigrationStatus' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Containers_MigrationStatus' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Containers_MigrationStatus' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation MigrationStatusWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.Containers.MigrationStatusWithHttpMessagesAsync($ResourceGroup, $FarmId, $OperationId)
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

