<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Returns a list of storage quotas at the given location.

.PARAMETER Skip
    Skip the first N items as specified by the parameter value.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Location
    Resource location.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota.

.PARAMETER Top
    Return the top N items as specified by the parameter value. Applies after the -Skip parameter.

.PARAMETER Name
    The name of the storage quota.

#>
function Get-AzsStorageQuota {
    [OutputType([Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota])]
    [CmdletBinding(DefaultParameterSetName = 'StorageQuotas_List')]
    param(    
        [Parameter(Mandatory = $false, ParameterSetName = 'StorageQuotas_List')]
        [int]
        $Skip = -1,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_StorageQuotas_Get')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'StorageQuotas_List')]
        [Parameter(Mandatory = $true, ParameterSetName = 'StorageQuotas_Get')]
        [System.String]
        $Location,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_StorageQuotas_Get')]
        [Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota]
        $InputObject,
    
        [Parameter(Mandatory = $false, ParameterSetName = 'StorageQuotas_List')]
        [int]
        $Top = -1,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'StorageQuotas_Get')]
        [Alias('QuotaName')]
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

        $QuotaName = $Name

 
        if ('InputObject_StorageQuotas_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_StorageQuotas_Get' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Storage.Admin/locations/{location}/quotas/{quotaName}'
            }

            if ('ResourceId_StorageQuotas_Get' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            }
            else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
            $location = $ArmResourceIdParameterValues['location']

            $quotaName = $ArmResourceIdParameterValues['quotaName']
        }

        $filterInfos = @(
            @{
                'Type'     = 'powershellWildcard'
                'Value'    = $QuotaName
                'Property' = 'Name' 
            })
        $applicableFilters = Get-ApplicableFilters -Filters $filterInfos
        if ($applicableFilters | Where-Object { $_.Strict }) {
            Write-Verbose -Message 'Performing server-side call ''Get-AzsStorageQuota -'''
            $serverSideCall_params = @{

            }

            $serverSideResults = Get-AzsStorageQuota @serverSideCall_params
            foreach ($serverSideResult in $serverSideResults) {
                $valid = $true
                foreach ($applicableFilter in $applicableFilters) {
                    if (-not (Test-FilteredResult -Result $serverSideResult -Filter $applicableFilter.Filter)) {
                        $valid = $false
                        break
                    }
                }

                if ($valid) {
                    $serverSideResult
                }
            }
            return
        }
        if ('StorageQuotas_Get' -eq $PsCmdlet.ParameterSetName -or 'InputObject_StorageQuotas_Get' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_StorageQuotas_Get' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation GetWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageQuotas.GetWithHttpMessagesAsync($Location, $QuotaName)
        }
        elseif ('StorageQuotas_List' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation ListWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.StorageQuotas.ListWithHttpMessagesAsync($Location)
        }
        else {
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
            $GetTaskResult_params['PageType'] = 'Microsoft.Rest.Azure.IPage[Microsoft.AzureStack.Management.Storage.Admin.Models.StorageQuota]' -as [Type]            
            Get-TaskResult @GetTaskResult_params
            
            Write-Verbose -Message 'Flattening paged results.'
            while ($PageResult -and $PageResult.Result -and (Get-Member -InputObject $PageResult.Result -Name 'nextLink') -and $PageResult.Result.'nextLink' -and (($TopInfo -eq $null) -or ($TopInfo.Max -eq -1) -or ($TopInfo.Count -lt $TopInfo.Max))) {
                $PageResult.Result = $null
                Write-Debug -Message "Retrieving next page: $($PageResult.Result.'nextLink')"
                $TaskResult = $StorageAdminClient.StorageQuotas.ListNextWithHttpMessagesAsync($PageResult.Result.'nextLink')
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

