<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create or update an existing storage quota.

.DESCRIPTION
    Create or update an existing storage quota.

.PARAMETER QuotaName
    The name of the storage quota.

.PARAMETER CapacityInGb
    Maxium capacity (GB).

.PARAMETER ResourceId
    The resource id.

.PARAMETER NumberOfStorageAccounts
    Total number of storage accounts.

.PARAMETER Location
    Resource location.

.PARAMETER InputObject
    Input object containing the updated quota properties.

.PARAMETER Force
    Do not ask for confirmation.

.EXAMPLE

    PS C:\> Set-AzsStorageQuota -QuotaName 'TestUpdateStorageQuota' -CapacityInGb 123 -NumberOfStorageAccounts 10 

    Update an existing storage quota.
#>
function Set-AzsStorageQuota {
    [OutputType([Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota])]
    [CmdletBinding(DefaultParameterSetName = 'Update', SupportsShouldProcess = $true)]

    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Update')]
        [System.String]
        $QuotaName,

        [Parameter(Mandatory = $false)]
        [int32]
        $CapacityInGb,

        [Parameter(Mandatory = $false)]
        [int32]
        $NumberOfStorageAccounts,

        [Parameter(Mandatory = $false, ParameterSetName = 'Update')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject')]
        [Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota]
        $InputObject,

        [Parameter(Mandatory = $false)]
        [switch]
        $Force
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

        if ('InputObject' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Storage.Admin/locations/{location}/quotas/{quotaName}'
            }

            if ('ResourceId' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
                $Quota = $InputObject
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $location = $ArmResourceIdParameterValues['location']

            $QuotaName = $ArmResourceIdParameterValues['quotaName']
        }

        # Should process
        if ($PSCmdlet.ShouldProcess("$QuotaName" , "Restore the storage account")) {
            if (-not ($Force.IsPresent -or $PSCmdlet.ShouldContinue("Restore the storage account?", "Performing operation UndeleteWithHttpMessagesAsync on $AccountId."))) {
                return
            }
        }

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

        if ($Location -eq $null) {
            $Location = (Get-AzureRMLocation).Location
        }

        if ('Update' -eq $PsCmdlet.ParameterSetName -or 'InputObject' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {

            # Get quota if not set
            if ($Quota -eq $null) {
                $Quota = Get-AzsStorageQuota -Location $Location -QuotaName $QuotaName
            }

            # Update the Quota object
            $flattenedParameters = @('CapacityInGb', 'NumberOfStorageAccounts')
            $flattenedParameters | ForEach-Object {
                if ($PSBoundParameters.ContainsKey($_)) {
                    $Quota.$($_) = $PSBoundParameters[$_]
                }
            }

            Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageQuotas.CreateOrUpdateWithHttpMessagesAsync($Location, $QuotaName, $Quota)
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
