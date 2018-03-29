<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.
#>

<#
.SYNOPSIS
    Power off a scale unit node.

.DESCRIPTION
    Power off a scale unit node.

.PARAMETER Name
    Name of the scale unit node.

.PARAMETER Location
    Location of the resource.

.PARAMETER ResourceGroupName
    Resource group in which the resource provider has been registered.

.PARAMETER ResourceId
    Scale unit node resource ID.

.PARAMETER Shutdown
    If set gracefully shutdown the scale unit node; otherwise hard power off the scale unit node.

.EXAMPLE

    PS C:\> Stop-AzsScaleUnitNode -Name "HC1n25r2236" -Shutdown

    Shutdown a scale unit node.

.EXAMPLE

    PS C:\> Stop-AzsScaleUnitNode -Name "HC1n25r2236"

    Power down a scale unit node.

#>
function Stop-AzsScaleUnitNode {
    [CmdletBinding(DefaultParameterSetName = 'Stop')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Stop')]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false, ParameterSetName = 'Stop')]
        [System.String]
        $Location,

        [Parameter(Mandatory = $false, ParameterSetName = 'Stop')]
        [ValidateLength(1, 90)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [Alias('id')]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $false)]
        [switch]$Shutdown,

        [Parameter(Mandatory = $false)]
        [switch]
        $Wait
    )

    Begin {
    }

    Process {

        # Get values
        if ('ResourceId' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fabric.Admin/fabricLocations/{location}/scaleUnitNodes/{scaleUnitNode}'
            }

            $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $ResourceGroupName = $ArmResourceIdParameterValues['resourceGroupName']
            $location = $ArmResourceIdParameterValues['location']
            $Name = $ArmResourceIdParameterValues['scaleUnitNode']
        } else {
            if (-not $PSBoundParameters.ContainsKey('Location')) {
                $Location = (Get-AzureRMLocation).Location
            }
            if (-not $PSBoundParameters.ContainsKey('ResourceGroupName')) {
                $ResourceGroupName = "System.$Location"
            }
        }

        if($Shutdown) {
            Submit-AzsScaleUnitNodeShutdown -Name $Name -ResourceGroupName $ResourceGroupName -Location $Location -Wait:$Wait
        } else {
            Submit-AzsScaleUnitNodeForceShutdown -Name $Name -ResourceGroupName $ResourceGroupName -Location $Location -Wait:$Wait
        }
    }

    End {
    }
}