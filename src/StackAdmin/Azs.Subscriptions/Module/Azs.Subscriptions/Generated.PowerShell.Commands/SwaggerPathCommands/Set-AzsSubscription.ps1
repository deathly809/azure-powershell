<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Create or updates a subscription.

.DESCRIPTION
    Create or updates a subscription.

.PARAMETER OfferId
    Identifier of the offer under the scope of a delegated provider.

.PARAMETER Id
    Fully qualified identifier.

.PARAMETER Type
    Type of resource.

.PARAMETER Tags
    List of key-value pairs.

.PARAMETER SubscriptionId
    Subscription identifier.

.PARAMETER State
    Subscription state.

.PARAMETER TenantId
    Directory tenant identifier.

.PARAMETER DisplayName
    Subscription name.

.PARAMETER Location
    Location where resource is location.

.PARAMETER ResourceId
    The resource ID.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Network.Admin.Models.Quota.

.EXAMPLE

    PS C:\> Set-AzsSubscription -SubscriptionId 2d9f5af9-3397-44fb-8700-d98762c2422a -DisplayName MyTestSub -State Enabled -OfferId /delegatedProviders/default/offers/offer1

    Create or updates a subscription.
#>
function Set-AzsSubscription
{
    [OutputType([Microsoft.AzureStack.Management.Subscriptions.Models.Subscription])]
    [CmdletBinding(DefaultParameterSetName='Set')]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = 'Set')]
        [ValidateNotNullOrEmpty()]
        [string]
        $OfferId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Set')]
        [string]
        $Type,

        [Parameter(Mandatory = $false, ParameterSetName = 'Set')]
        [System.Collections.Generic.Dictionary[[string],[string]]]
        $Tags,

        [Parameter(Mandatory = $true, ParameterSetName = 'Set')]
        [ValidateNotNullOrEmpty()]
        [string]
        $SubscriptionId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Set')]
        [ValidateSet('NotDefined', 'Enabled', 'Warned', 'PastDue', 'Disabled', 'Deleted')]
        [ValidateNotNullOrEmpty()]
        [string]
        $State,

        [Parameter(Mandatory = $false, ParameterSetName = 'Set')]
        [string]
        $TenantId,

        [Parameter(Mandatory = $false, ParameterSetName = 'Set')]
        [string]
        $DisplayName,

        [Parameter(Mandatory = $false, ParameterSetName = 'Set')]
        [string]
        [Alias("ArmLocation")]        
        $Location,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [Alias('id')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject')]
        [Microsoft.AzureStack.Management.Subscriptions.Models.Subscription]
        $InputObject
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

    if ($PSBoundParameters.ContainsKey('Location')) {
        if( $MyInvocation.Line -match "\s-ArmLocation\s")
        {
            Write-Warning -Message "The parameter alias ArmLocation will be deprecated in future release. Please use the parameter Location instead"
        }
    }

    $NewServiceClient_params = @{
        FullClientTypeName = 'Microsoft.AzureStack.Management.Subscriptions.SubscriptionsManagementClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

    $SubscriptionsManagementClient = New-ServiceClient @NewServiceClient_params

	$updatedSubscription = $null

	if ( 'InputObject' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName ) {
	    $GetArmResourceIdParameterValue_params = @{
		    IdTemplate = '/subscriptions/{subscriptionId}'
	    }

		if ('ResourceId' -eq $PsCmdlet.ParameterSetName) {
			$GetArmResourceIdParameterValue_params['Id'] = $ResourceId
		} else {
			$GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
			$updatedSubscription = $InputObject
		}
		$ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

	    $SubscriptionId = $ArmResourceIdParameterValues['subscriptionId']
	}

    if ('Set' -eq $PsCmdlet.ParameterSetName -or 'InputObject' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {

		if ($updatedSubscription -eq $null)
		{
			$updatedSubscription = Get-AzsSubscription -SubscriptionId $SubscriptionId
		}

	    $flattenedParameters = @('OfferId', 'Id', 'Type', 'Tags', 'SubscriptionId', 'State', 'TenantId', 'Location', 'DisplayName')
        $flattenedParameters | ForEach-Object {
            if ($PSBoundParameters.ContainsKey($_)) {
                $updatedSubscription.$($_) = $PSBoundParameters[$_]
            }
        }

        Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $SubscriptionsManagementClient.'
        $TaskResult = $SubscriptionsManagementClient.Subscriptions.CreateOrUpdateWithHttpMessagesAsync($SubscriptionId, $updatedSubscription)

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

