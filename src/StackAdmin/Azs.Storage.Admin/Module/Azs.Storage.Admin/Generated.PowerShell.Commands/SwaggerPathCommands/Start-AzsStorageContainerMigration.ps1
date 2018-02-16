<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    

.DESCRIPTION
    Starts a container migration job to migrate containers to the specified destination share.

.PARAMETER StorageAccountName
    The name of storage account where the container locates.

.PARAMETER ContainerName
    NThe name of the container to be migrated.

.PARAMETER ShareName
    Share name.

.PARAMETER ResourceGroupName
    Resource group name.

.PARAMETER FarmId
    Farm Id.

.PARAMETER DestinationShareUncPath
    The UNC path of the destination share for migration.

#>
function Start-AzsStorageContainerMigration {
    [CmdletBinding(DefaultParameterSetName = 'Containers_Migrate')]
    param(    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_Migrate')]
        [string]
        $StorageAccountName,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_Migrate')]
        [string]
        $ContainerName,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_Migrate')]
        [System.String]
        $ShareName,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_Migrate')]
        [System.String]
        $ResourceGroup,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_Migrate')]
        [System.String]
        $FarmId,
    
        [Parameter(Mandatory = $true, ParameterSetName = 'Containers_Migrate')]
        [string]
        $DestinationShareUncPath,

        [Parameter(Mandatory = $false)]
        [switch]
        $AsJob
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

        
        $flattenedParameters = @('ContainerName', 'StorageAccountName', 'DestinationShareUncPath')
        $utilityCmdParams = @{}
        $flattenedParameters | ForEach-Object {
            if ($PSBoundParameters.ContainsKey($_)) {
                $utilityCmdParams[$_] = $PSBoundParameters[$_]
            }
        }
        $MigrationParameters = New-MigrationParametersObject @utilityCmdParams



        if ('Containers_Migrate' -eq $PsCmdlet.ParameterSetName) {
            Write-Verbose -Message 'Performing operation MigrateWithHttpMessagesAsync on $StorageAdminClient.'
            $TaskResult = $StorageAdminClient.Containers.MigrateWithHttpMessagesAsync($ResourceGroup, $FarmId, $ShareName, $MigrationParameters)
        }
        else {
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
        if ($AsJob) {
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
        else {
            Invoke-Command -ScriptBlock $PSSwaggerJobScriptBlock `
                -ArgumentList $TaskResult, $TaskHelperFilePath `
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

