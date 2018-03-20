<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Returns a list of products downloaded from Azure MarketPlace.

.DESCRIPTION
    Returns a list of products downloaded from Azure MarketPlace.

.PARAMETER ActivationName
    Name of the activation.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.PARAMETER ResourceId
    The resource id.

.PARAMETER ResourceGroupName
    The resource group the resource is located under.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.AzureBridge.Admin.Models.DownloadedProductResource.

.PARAMETER Name
    Name of the product.

.Example
    # Get a list of Azure Bridge Downloaded products
    Get-AzsAzureBridgeDownloadedProduct -ActivationName 'myActivation' -ResourceGroupName 'activationRG'
    
.Example
    # Get an Azure Bridge Downloaded Product by Name
    Get-AzsAzureBridgeDownloadedProduct -Name 'microsoft.docker-arm.1.1.0' -ActivationName 'myActivation' -ResourceGroupName 'activationRG'  
#>
function Get-AzsAzureBridgeDownloadedProduct {
    [OutputType([Microsoft.AzureStack.Management.AzureBridge.Admin.Models.DownloadedProductResource])]
    [CmdletBinding(DefaultParameterSetName = 'DownloadedProducts_List')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'DownloadedProducts_Get')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'DownloadedProducts_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'DownloadedProducts_Get')]
        [System.String]
        $ActivationName,

        [Parameter(Mandatory = $true, ParameterSetName = 'DownloadedProducts_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'DownloadedProducts_Get')]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_DownloadedProducts_Get')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $false, ParameterSetName = 'DownloadedProducts_List')]
        [int]
        $Skip = -1,

        [Parameter(Mandatory = $false, ParameterSetName = 'DownloadedProducts_List')]
        [int]
        $Top = -1
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
            FullClientTypeName = 'Microsoft.AzureStack.Management.AzureBridge.Admin.AzureBridgeAdminClient'
        }

        $GlobalParameterHashtable = @{}
        $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

        $GlobalParameterHashtable['SubscriptionId'] = $null
        if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
        }

        $AzureBridgeAdminClient = New-ServiceClient @NewServiceClient_params

        if ('InputObject_DownloadedProducts_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_DownloadedProducts_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}/providers/Microsoft.AzureBridge.Admin/activations/{activationName}/downloadedProducts/{productName}'
            }

            if ('ResourceId_DownloadedProducts_Get' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroup']

            $activationName = $ArmResourceIdParameterValues['activationName']

            $Name = $ArmResourceIdParameterValues['productName']
        }


        if ('DownloadedProducts_List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $AzureBridgeAdminClient.'
            $TaskResult = $AzureBridgeAdminClient.DownloadedProducts.ListWithHttpMessagesAsync($ResourceGroupName, $ActivationName)
        } elseif ('DownloadedProducts_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_DownloadedProducts_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_DownloadedProducts_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $AzureBridgeAdminClient.'
            $TaskResult = $AzureBridgeAdminClient.DownloadedProducts.GetWithHttpMessagesAsync($ResourceGroupName, $ActivationName, $Name)
        } else {
            Write-Verbose -Message 'Failed to map parameter set to operation method.'
            throw 'Module failed to find operation to execute.'
        }

        if ($TaskResult) {
            $GetTaskResult_params = @{
                TaskResult = $TaskResult
            }

            $TopInfo = @{
                'Count' = 0
                'Max'   = $Top
            }
            $GetTaskResult_params['TopInfo'] = $TopInfo
            $SkipInfo = @{
                'Count' = 0
                'Max'   = $Skip
            }
            $GetTaskResult_params['SkipInfo'] = $SkipInfo
            $PageResult = @{
                'Result' = $null
            }
            $GetTaskResult_params['PageResult'] = $PageResult
            $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.AzureBridge.Admin.Models.DownloadedProductResource]' -as [Type]
            Get-TaskResult @GetTaskResult_params

            Write-Verbose -Message 'Flattening paged results.'
            while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
                $PageResult.Result = $null
                Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
                $TaskResult = $AzureBridgeAdminClient.DownloadedProducts.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
                $GetTaskResult_params['TaskResult'] = $TaskResult
                $GetTaskResult_params['PageResult'] = $PageResult
                Get-TaskResult @GetTaskResult_params
            }
        }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}
