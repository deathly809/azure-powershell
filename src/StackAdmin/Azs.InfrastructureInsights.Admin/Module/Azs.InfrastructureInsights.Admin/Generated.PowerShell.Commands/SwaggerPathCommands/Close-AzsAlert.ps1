<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Closes the given alert.

.PARAMETER Description
    Description of the alert.

.PARAMETER Remediation
    Admin friendly remediation instructions for the alert.

.PARAMETER FaultId
    Fault id of the alert.

.PARAMETER ResourceRegistrationId
    Registration id of the atomic component the alert belongs to.  This is null if not associated with a resource.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert.

.PARAMETER Location
    Location where resource is location.

.PARAMETER LastUpdatedTimestamp
    Timestamp when the alert was last updated.

.PARAMETER User
    The username used to perform the operation.

.PARAMETER AlertProperties
    Properties of the alert.

.PARAMETER Severity
    Severity of the alert.

.PARAMETER State
    State of the alert.

.PARAMETER Title
    Title of the alert.

.PARAMETER ClosedByUserAlias
    User alias who closed the alert.

.PARAMETER ResourceId
    The resource id.

.PARAMETER ImpactedResourceDisplayName
    Display name for the impacted item.

.PARAMETER FaultTypeId
    Fault type id of the alert.

.PARAMETER Region
    Name of the region

.PARAMETER CreatedTimestamp
    Timestamp when the alert was created.

.PARAMETER Id
    URI of the resource.

.PARAMETER ResourceGroupName
    resourceGroupName.

.PARAMETER Name
    Name of the alert.

.PARAMETER Tags
    List of key value pairs.

.PARAMETER Type
    Type of resource.

.PARAMETER ImpactedResourceId
    ResourceId for the impacted item.

.PARAMETER ResourceProviderRegistrationId
    Registration id of the service the alert belongs to.

.PARAMETER Name
    Name of the resource.

.PARAMETER AlertId
    Id of the alert.

.PARAMETER ClosedTimestamp
    Timestamp when the alert was closed.

#>
function Close-AzsAlert
{
    [OutputType([Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert])]
    param(    
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_Alerts_Close')]
        [Microsoft.AzureStack.Management.InfrastructureInsights.Admin.Models.Alert]
        $InputObject,

        [Parameter(Mandatory = $false, ParameterSetName = 'InputObject_Alerts_Close')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ResourceId_Alerts_Close')]
        [System.String]
        $User,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_Alerts_Close')]
        [System.String]
        $ResourceId
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.InfrastructureInsights.Admin.InfrastructureInsightsAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable
     
    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $InfrastructureInsightsAdminClient = New-ServiceClient @NewServiceClient_params
 
    if('InputObject_Alerts_Close' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Alerts_Close' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.InfrastructureInsights.Admin/regionHealths/{region}/alerts/{alertName}'
        }

        if('ResourceId_Alerts_Close' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            $Alert = Get-AzsAlert -ResourceId $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            $Alert = $InputObject
        }

        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $region = $ArmResourceIdParameterValues['region']

        $alertName = $ArmResourceIdParameterValues['alertName']

        if(-not $User) {
            $ctx = Get-AzureRmContext
            $User = $ctx.Account.Id
        }
    }


    if ('Alerts_Close' -eq $PsCmdlet.ParameterSetName -or 'InputObject_Alerts_Close' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_Alerts_Close' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CloseWithHttpMessagesAsync on $InfrastructureInsightsAdminClient.'
        $TaskResult = $InfrastructureInsightsAdminClient.Alerts.CloseWithHttpMessagesAsync($ResourceGroupName, $Region, $AlertName, $User, $Alert)
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

