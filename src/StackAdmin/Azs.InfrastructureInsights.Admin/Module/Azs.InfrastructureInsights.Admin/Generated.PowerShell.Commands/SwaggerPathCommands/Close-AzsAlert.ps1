<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Closes the given alert.

.DESCRIPTION
    Closes the given alert.

.PARAMETER AlertId
    The alert identifier.

.PARAMETER User
    The username used to perform the operation.

.PARAMETER Location
    Name of the location.

.PARAMETER ResourceGroupNameName
    resourceGroupName.

.PARAMETER ResourceId
    The resource id.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert.

.EXAMPLE

    PS C:\> Close-AzsAlert -AlertId f2147f3d-42ac-4316-8cbc-f0f9c18888b0

    Close an alert by AlertId.

.EXAMPLE

    PS C:\> Get-AzsAlert -AlertId f2147f3d-42ac-4316-8cbc-f0f9c18888b0 | Close-AzsAlert

    Close an alert through piping.

#>
function Close-AzsAlert {
    [OutputType([Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert])]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Close')]
        [System.String]
        $AlertId,

        [Parameter(Mandatory = $false)]
        [System.String]
        $User,

        [Parameter(Mandatory = $false, ParameterSetName = 'Close')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'Close')]
        [ValidateLength(1, 90)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject')]
        [Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert]
        $InputObject,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
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

        $ErrorActionPreference = 'Stop'

        $NewServiceClient_params = @{
            FullClientTypeName = 'Microsoft.AzureStack.Management.InfrastructureInsights.Admin.InfrastructureInsightsAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $Alert = $null

        $InfrastructureInsightsAdminClient = New-ServiceClient @NewServiceClient_params

        if ('InputObject' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.InfrastructureInsights.Admin/regionHealths/{region}/alerts/{alertName}'
            }

            if ('ResourceId' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId

            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
                $Alert = $InputObject
            }

            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']
            $Location = $ArmResourceIdParameterValues['region']
            $AlertId = $ArmResourceIdParameterValues['alertName']
        } else {
            if ( -not $PSBoundParameters.ContainsKey('Location')) {
                $Location = (Get-AzureRMLocation).Location
            }

            if (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
                $ResourceGroupName = "System.$Location"
            }
        }

        if ($Alert -eq $null) {
            $Alert = Get-AzsAlert -AlertId  $AlertId
        }

        Write-Output -InputObject ($Alert | FL *)

        if (-not $User) {
            $ctx = Get-AzureRmContext
            $User = $ctx.Account.Id
        }

        if ('Close' -eq $PsCmdlet.ParameterSetName -or 'InputObject' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation CloseWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
            $TaskResult = $InfrastructureInsightsAdminClient.Alerts.CloseWithHttpMessagesAsync($ResourceGroupName, $Location, $AlertId, $User, $Alert)
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
