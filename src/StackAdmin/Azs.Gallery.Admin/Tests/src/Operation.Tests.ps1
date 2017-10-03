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
    Run AzureStack fabric admin edge gateway pool tests.

.DESCRIPTION
    Run AzureStack fabric admin edge gateway pool tests using either mock client or our client.
	The mock client allows for recording and playback.  This allows for offline tests.

.PARAMETER RunRaw
    Run using our client creation path.

.EXAMPLE
    C:\PS> .\src\Alert.Tests.ps1
	Describing Alerts
	[+] TestListAlerts 349ms
	[+] TestGetAlert 175ms
	[+] TestGetAllAlerts 866ms
	[+] TestCloseAlert 171ms
	
.NOTES
    Author: Jeffrey Robinson
	Copyright: Microsoft
    Date:   August 24, 2017
#>
param(
	[bool]$RunRaw = $false
)

$Global:RunRaw = $RunRaw

. $PSScriptRoot\CommonModules.ps1

InModuleScope Azs.Gallery.Admin {

	Describe "Alerts" -Tags @('Alert', 'GalleryAdmin') {
	
		BeforeEach  {
			. $PSScriptRoot\Common.ps1
		}


		It "TestGetOperations" {
			$global:TestName = 'TestGetOperations'

			$operations = Get-AzsGalleryOperationList
			$operations			| Should Not Be $null
			$operations.Count	| Should Be 4
		}

	}
}