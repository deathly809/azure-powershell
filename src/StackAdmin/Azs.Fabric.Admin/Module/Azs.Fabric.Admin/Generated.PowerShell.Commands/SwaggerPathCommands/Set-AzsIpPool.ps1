<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Create an Ip pool.  Once created an Ip pool cannot be deleted.

.PARAMETER Pool
    Ip pool object to send.

.PARAMETER Name
    Ip pool name.

.PARAMETER ResourceGroupName
    Name of the resource group.

.PARAMETER ResourceId
    The resource id.

.PARAMETER Location
    Location of the resource.

.PARAMETER InputObject
    The input object of type Microsoft.AzureStack.Management.Fabric.Admin.Models.IpPool.

#>
function Set-AzsIpPool
{
    [OutputType([Microsoft.AzureStack.Management.Fabric.Admin.Models.ProvisioningState])]
    [CmdletBinding(DefaultParameterSetName='IpPools_CreateOrUpdate')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'IpPools_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'InputObject_IpPools_CreateOrUpdate')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ResourceId_IpPools_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Fabric.Admin.Models.IpPool]
        $Pool,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'IpPools_CreateOrUpdate')]
        [Alias('IpPool')]
        [System.String]
        $Name,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'IpPools_CreateOrUpdate')]
        [System.String]
        $ResourceGroupName,
    
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId_IpPools_CreateOrUpdate')]
        [System.String]
        $ResourceId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'IpPools_CreateOrUpdate')]
        [System.String]
        $Location,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject_IpPools_CreateOrUpdate')]
        [Microsoft.AzureStack.Management.Fabric.Admin.Models.IpPool]
        $InputObject,

        [Parameter(Mandatory = $false)]
        [switch]
        $AsJob
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
        FullClientTypeName = 'Microsoft.AzureStack.Management.Fabric.Admin.FabricAdminClient'
    }

    $GlobalParameterHashtable = @{}
    $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable
     
    $GlobalParameterHashtable['SubscriptionId'] = $null
    if($PSBoundParameters.ContainsKey('SubscriptionId')) {
        $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
    }

    $FabricAdminClient = New-ServiceClient @NewServiceClient_params

    $IpPool = $Name

 
    if('InputObject_IpPools_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_IpPools_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        $GetArmResourceIdParameterValue_params = @{
            IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fabric.Admin/fabricLocations/{location}/ipPools/{ipPool}'
        }

        if('ResourceId_IpPools_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
        }
        else {
            $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
        }
        $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params
        $resourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']

        $location = $ArmResourceIdParameterValues['location']

        $ipPool = $ArmResourceIdParameterValues['ipPool']
    }


    if ('IpPools_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'InputObject_IpPools_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName -or 'ResourceId_IpPools_CreateOrUpdate' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation CreateOrUpdateWithHttpMessagesAsync on $FabricAdminClient.'
        $TaskResult = $FabricAdminClient.IpPools.CreateOrUpdateWithHttpMessagesAsync($ResourceGroupName, $Location, $IpPool, $Pool)
    } else {
        Write-Verbose -Message 'Failed to map parameter set to operation method.'
        throw 'Module failed to find operation to execute.'
    }

    Write-Verbose -Message "Waiting for the operation to complete."

    $PSSwaggerJobScriptBlock = {
        [CmdletBinding()]
        param(    
            [Parameter(Mandatory = $true)]
            [System.Threading.Tasks.Task]
            $TaskResult,

            [Parameter(Mandatory = $true)]
			[string]
			$TaskHelperFilePath
        )
        if ($TaskResult) {
            . $TaskHelperFilePath
            $GetTaskResult_params = @{
                TaskResult = $TaskResult
            }
            
            Get-TaskResult @GetTaskResult_params
            
        }
    }

    $PSCommonParameters = Get-PSCommonParameter -CallerPSBoundParameters $PSBoundParameters
    $TaskHelperFilePath = Join-Path -Path $ExecutionContext.SessionState.Module.ModuleBase -ChildPath 'Get-TaskResult.ps1'
    if($AsJob)
    {
        $ScriptBlockParameters = New-Object -TypeName 'System.Collections.Generic.Dictionary[string,object]'
        $ScriptBlockParameters['TaskResult'] = $TaskResult
        $ScriptBlockParameters['AsJob'] = $AsJob
        $ScriptBlockParameters['TaskHelperFilePath'] = $TaskHelperFilePath
        $PSCommonParameters.GetEnumerator() | ForEach-Object { $ScriptBlockParameters[$_.Name] = $_.Value }

        Start-PSSwaggerJobHelper -ScriptBlock $PSSwaggerJobScriptBlock `
                                     -CallerPSBoundParameters $ScriptBlockParameters `
                                     -CallerPSCmdlet $PSCmdlet `
                                     @PSCommonParameters
    }
    else
    {
        Invoke-Command -ScriptBlock $PSSwaggerJobScriptBlock `
                       -ArgumentList $TaskResult,$TaskHelperFilePath `
                       @PSCommonParameters
    }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}

