# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.SYNOPSIS
    Run AzureStack AzureBridge admin edge gateway tests.

.DESCRIPTION
    Run AzureStack AzureBridge admin edge gateway tests using either mock client or our client.
	The mock client allows for recording and playback.  This allows for offline tests.

.PARAMETER RunRaw
    Run using our client creation path.

.PARAMETER UseInstalled
    Use the locally installed modules.

.EXAMPLE
    PS C:\> .\src\Activation.Tests.ps1
    Describing Activations
	 [+] TestListActivations 81ms
	 [+] TestGetActivation 73ms
	 [+] TestGetAllActivations 66ms

.NOTES
#>
param(
    [bool]$RunRaw = $false,
    [bool]$UseInstalled = $false
)

$global:UseInstalled = $UseInstalled
$global:RunRaw = $RunRaw
$global:TestName = ""

. $PSScriptRoot\CommonModules.ps1
. $PSScriptRoot\Common.ps1

$global:SkipList = @(
    "TestDownloadAzsAzureBridgeProductPipeline",
    "TestRemoveAzsAzureBridgeDownloadedProduct",
    "TestRemoveAzsAzureBridgeDownloadedProductPipeline"
)
$global:ActivationName = "default"
$global:ResourceGroupName = "azurestack-activation"
$global:ProductName1 = "Canonical.UbuntuServer1710-ARM.1.0.6"
$global:ProductName2 = "microsoft.docker-arm.1.1.0"

if (Test-Path "$PSScriptRoot\Override.ps1") {
    . $PSScriptRoot\Override.ps1
}

InModuleScope Azs.AzureBridge.Admin {

    Describe "AzsAzureBridgeActivation" -Tags @('AzureBridgeActivation', 'Azs.AzureBridge.Admin') {

        BeforeEach {
            function ValidateActivationInfo {
                param(
                    [Parameter(Mandatory = $true)]
                    $Activation
                )

                $Activation          | Should Not Be $null

                # Resource
                $Activation.Id       | Should Not Be $null
                $Activation.Name     | Should Not Be $null
                $Activation.Type     | Should Not Be $null

                $Activation.ProvisioningState    | Should Not Be $null
                $Activation.Expiration         | Should Not Be $null
                $Activation.MarketplaceSyndicationEnabled        | Should Not Be $null
                $Activation.AzureRegistrationResourceIdentifier  | Should Not Be $null
                $Activation.Location    | Should Not Be $null
                $Activation.DisplayName  | Should Not Be $null

            }
        }

        It "TestListAzsAzureBridgeActivation" {
            $global:TestName = "TestListAzsAzureBridgeActivation"
            $Activations = Get-AzsAzureBridgeActivation -ResourceGroupName $global:ResourceGroupName

            Foreach ($Activation in $Activations) {
                ValidateActivationInfo -Activation $Activation
            }
        }

        It "TestGetAzsAzureBridgeActivationByName" {
            $global:TestName = "TestGetAzsAzureBridgeActivationByName"
            $Activation = Get-AzsAzureBridgeActivation -Name $global:ActivationName -ResourceGroupName $global:ResourceGroupName
            ValidateActivationInfo -Activation $Activation
        }
    }

    Describe "AzsAzureBridgeProduct" {
        BeforeEach {

            function ValidateProductInfo {
                param(
                    [Parameter(Mandatory = $true)]
                    $Product
                )

                $Product          | Should Not Be $null

                # Resource
                $Product.Id       | Should Not Be $null
                $Product.Name     | Should Not Be $null
                $Product.Type     | Should Not Be $null

                $Product.GalleryItemIdentity    | Should Not Be $null
                $Product.ProductKind         | Should Not Be $null
                $Product.ProductProperties        | Should Not Be $null
                # $Product.Description  | Should Not Be $null
                $Product.DisplayName  | Should Not Be $null

            }
        }

        Context "Get-AzsAzureBridgeProduct" {

            It "TestListAzsAzureBridgeProduct" -Skip:$("TestListAzsAzureBridgeProduct" -in $global:SkipList) {
                $global:TestName = "TestListAzsAzureBridgeProduct"
                $Products = Get-AzsAzureBridgeProduct -ActivationName $global:ActivationName -ResourceGroupName $global:ResourceGroupName
                foreach ($Product in $Products) {
                    ValidateProductInfo $Product
                }
            }

            It "TestGetAzsAzureBridgeProductByName" -Skip:$("TestGetAzsAzureBridgeProductByName" -in $global:SkipList) {
                $global:TestName = "TestGetAzsAzureBridgeProductByName"
                $Product = Get-AzsAzureBridgeProduct -ActivationName $global:ActivationName -ResourceGroupName $global:ResourceGroupName -Name $global:ProductName1
                ValidateProductInfo $Product
            }

        }

        # Re-record
        Context "Invoke-AzsAzureBridgeProductDownload" {

            It "TestDownloadAzsAzureBridgeProduct" -Skip:$("TestDownloadAzsAzureBridgeProduct" -in $global:SkipList) {
                $global:TestName = "TestDownloadAzsAzureBridgeProduct"
                Invoke-AzsAzureBridgeProductDownload -ActivationName $global:ActivationName -Name $global:ProductName1 -ResourceGroupName $global:ResourceGroupName -Force -ErrorAction Stop
            }

            It "TestDownloadAzsAzureBridgeProductPipeline" -Skip:$("TestDownloadAzsAzureBridgeProductPipeline" -in $global:SkipList) {
                $global:TestName = "TestDownloadAzsAzureBridgeProductPipeline"
                $DownloadedProduct = (Get-AzsAzureBridgeProduct -ActivationName $global:ActivationName -Name $global:ProductName2 -ResourceGroupName $global:ResourceGroupName)  | Invoke-AzsAzureBridgeProductDownload -Force
                ValidateProductInfo $DownloadedProduct
            }
        }

        Context "Get-AzsAzureBridgeDownloadedProduct" {

            It "TestGetAzsAzureBridgeDownloadedProduct" -Skip:$("TestGetAzsAzureBridgeDownloadedProduct" -in $global:SkipList) {
                $global:TestName = "TestGetAzsAzureBridgeDownloadedProduct"
                $DownloadedProducts = (Get-AzsAzureBridgeDownloadedProduct -ActivationName $global:ActivationName -ResourceGroupName $global:ResourceGroupName  )
                foreach ($DownloadedProduct in $DownloadedProducts) {
                    ValidateProductInfo $DownloadedProduct
                }
            }

            It "TestGetAzsAzureBridgeDownloadedProductByProductName" -Skip:$("TestGetAzsAzureBridgeDownloadedProductByProductName" -in $global:SkipList) {
                $global:TestName = "TestGetAzsAzureBridgeDownloadedProductByProductName"
                $DownloadedProduct = (Get-AzsAzureBridgeDownloadedProduct -ActivationName $global:ActivationName -Name $global:ProductName1 -ResourceGroupName $global:ResourceGroupName  )
                ValidateProductInfo $DownloadedProduct
            }
        }

        # Not able to remove because of the error: {"code":"RequestConflict","message":"Cannot modify resource with id '/subscriptions/b6a34e73-810f-4564-881a-8434c6c2e5c8/resourceGroups/azurestack-activation/providers/Microsoft.AzureBridge.Admin/activations/default/downloadedProducts/Canonical.UbuntuServer1710-ARM.1.0.6' because the resource entity provisioning state is not terminal. Please wait for the provisioning state to become terminal and then retry the request."}}
        Context "Remove-AzsAzureBridgeDownloadedProduct" {

            It "TestRemoveAzsAzureBridgeDownloadedProduct" -Skip:$("TestRemoveAzsAzureBridgeDownloadedProduct" -in $global:SkipList) {
                $global:TestName = "TestRemoveAzsAzureBridgeDownloadedProduct"
                Remove-AzsAzureBridgeDownloadedProduct -ActivationName $global:ActivationName -ResourceGroupName $global:ResourceGroupName -Name $global:ProductName1 -Force
                Get-AzsAzureBridgeDownloadedProduct -ActivationName $global:ActivationName -ResourceGroupName $global:ResourceGroupName -Name $global:ProductName1 | Should Be $null
            }

            It "TestRemoveAzsAzureBridgeDownloadedProductPipeline" -Skip:$("TestRemoveAzsAzureBridgeDownloadedProductPipeline" -in $global:SkipList) {
                $global:TestName = "TestRemoveAzsAzureBridgeDownloadedProductPipeline"
                (Get-AzsAzureBridgeDownloadedProduct -ActivationName $global:ActivationName -Name $global:ProductName2 -ResourceGroupName $global:ResourceGroupName ) | Remove-AzsAzureBridgeDownloadedProduct  -Force
                Get-AzsAzureBridgeDownloadedProduct -ActivationName $global:ActivationName -ResourceGroupName $global:ResourceGroupName -Name $global:ProductName2 | Should Be $null
            }
        }
    }
}
