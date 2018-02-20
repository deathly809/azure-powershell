<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Repairs a node of the cluster.

.PARAMETER ResourceGroupName
    Name of the resource group.

.PARAMETER BareMetalNode
    Description of a node.

.PARAMETER ScaleUnitNode
    Name of the scale unit node.

.PARAMETER Location
    Location of the resource.

#>
function Repair-AzsScaleUnitNode
{
    [CmdletBinding(DefaultParameterSetName='ScaleUnitNodes_Repair')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'ScaleUnitNodes_Repair')]
        [System.String]
        $ResourceGroupName,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'ScaleUnitNodes_Repair')]
        [Microsoft.AzureStack.Management.Fabric.Admin.Models.BareMetalNodeDescription]
        $BareMetalNode,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'ScaleUnitNodes_Repair')]
        [System.String]
        $ScaleUnitNode,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'ScaleUnitNodes_Repair')]
        [System.String]
        $Location,

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


    if ('ScaleUnitNodes_Repair' -eq $PsCmdlet.ParameterSetName) {
        Write-Verbose -Message 'Performing operation RepairWithHttpMessagesAsync on $FabricAdminClient.'
        $TaskResult = $FabricAdminClient.ScaleUnitNodes.RepairWithHttpMessagesAsync($ResourceGroupName, $Location, $ScaleUnitNode, $BareMetalNode)
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

