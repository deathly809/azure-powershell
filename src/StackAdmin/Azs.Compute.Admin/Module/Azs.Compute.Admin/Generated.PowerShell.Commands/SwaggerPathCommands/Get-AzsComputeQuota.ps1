<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.

Code generated by Microsoft (R) PSSwagger
Changes may cause incorrect behavior and will be lost if the code is regenerated.
#>

<#
.SYNOPSIS
    Returns quotas specifying the quota limits for compute objects.

.DESCRIPTION
    Get a list of existing quotas.

.PARAMETER Name
    Name of the quota.

.PARAMETER LocationName
    Location of the resource.

.PARAMETER ResourceId
    The resource id.

.EXAMPLE

    PS C:\> Get-AzsComputeQuota -Location 'local'

    Get all compute quotas at the specified location.

.EXAMPLE

    PS C:\> Get-AzsComputeQuota 'Default Quota'

    Get a specific compute quota.

#>
using module '..\CustomObjects\ComputeQuotaObject.psm1'

function Get-AzsComputeQuota {
    [OutputType([ComputeQuotaObject])]
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Get', Position = 0)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false, ParameterSetName = 'Get')]
        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [Alias('id')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $ResourceId
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

        $NewServiceClient_params = @{
            FullClientTypeName = 'Microsoft.AzureStack.Management.Compute.Admin.ComputeAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $ComputeAdminClient = New-ServiceClient @NewServiceClient_params

        if ('ResourceId' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Compute.Admin/locations/{locationName}/quotas/{quotaName}'
            }

            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $Location = $ArmResourceIdParameterValues['locationName']
            $Name = $ArmResourceIdParameterValues['quotaName']
        } elseif ([System.String]::IsNullOrEmpty($Location)) {
            $Location = (Get-AzureRMLocation).Location
        }

        if ('Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
            $Name = Get-ResourceNameSuffix -ResourceName $Name
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $ComputeAdminClient.'
            $TaskResult = $ComputeAdminClient.Quotas.GetWithHttpMessagesAsync($Location, $Name)
        } elseif ('List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $ComputeAdminClient.'
            $TaskResult = $ComputeAdminClient.Quotas.ListWithHttpMessagesAsync($Location)
        } else {
            Write-Verbose -Message 'Failed to map parameter set to operation method.'
            throw 'Module failed to find operation to execute.'
        }

        if ($TaskResult) {
            $GetTaskResult_params = @{
                TaskResult = $TaskResult
            }
            Get-TaskResult @GetTaskResult_params | ForEach-Object { ConvertTo-ComputeQuota -Quota $_ }
        }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}
