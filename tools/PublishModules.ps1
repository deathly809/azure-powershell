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

param(
    [Parameter(Mandatory = $false, Position = 0)]
    [switch]$IsNetCore,
    [Parameter(Mandatory = $false, Position = 1)]
    [string]$BuildConfig,
    [Parameter(Mandatory = $false, Position = 2)]
    [string]$Scope = 'All',
    [Parameter(Mandatory = $false, Position = 3)]
    [string]$ApiKey,
    [Parameter(Mandatory = $false, Position = 4)]
    [string]$RepositoryLocation,
    [Parameter(Mandatory = $false, Position = 5)]
    [string]$NugetExe,
    [Parameter(Mandatory=$false)]
    [ValidateSet("Latest", "Stack")]
    [string]$Profile = "Latest"
)

#
#   Get the package folder and resourceManagerRoolFolders
#
function Get-Directories {
    [CmdletBinding()]
    param
    (
        [string]$BuildConfig,
        [switch]$IsNetCore
    )

    PROCESS {
        $packageFolder = "$PSScriptRoot\..\src\Package"
        if ($Profile -eq "Stack")
        {
            $packageFolder = "$PSScriptRoot\..\src\Stack"
        }

        if($isNetCore) {
            $resourceManagerRootFolder = "$packageFolder\$buildConfig\ResourceManager"
        } else {
            $resourceManagerRootFolder = "$packageFolder\$buildConfig\ResourceManager\AzureResourceManager"
        }
        Write-Output -InputObject $packageFolder, $resourceManagerRootFolder
    }
}

#
#   Get the list of rollup modules, AzureRM and AzureRM.Profile
#
function Get-RollupModules {
    [CmdletBinding()]
    param
    (
        [string]$BuildConfig,
        [string]$Scope,
        [switch]$IsNetCore
    )

    PROCESS {
        $targets = @()

        $packageFolder, $resourceManagerRootFolder = Get-Directories -BuildConfig $BuildConfig -IsNetCore:$IsNetCore

        if (($Scope -eq 'All') -or ($Scope -eq 'AzureRM')) {
            if ($Profile -eq "Stack")
            {
                $targets += "$PSScriptRoot\..\src\StackAdmin\AzureRM"
                $targets += "$PSScriptRoot\..\src\StackAdmin\AzureStack"
            }
            if($IsNetCore) {
                # For .NetCore publish AzureRM.Netcore
                $targets += "$PSScriptRoot\AzureRM.Netcore"
            }
        }
        Write-Output -InputObject $targets
    }
}

#
#   Get the list of admin modules, Azs.Commerce.Admin, Asz.KeyVault.Admin, etc...
#
function Get-AdminModules
{
    [CmdletBinding()]
    param
    (
        [string]$BuildConfig,
        [string]$Scope,
        [switch]$IsNetCore
    )

    PROCESS
    {
        $targets = @()
        if (($Scope -eq 'All') -or ($Scope -eq "Stack"))
        {
            $packageFolder, $resourceManagerRootFolder = Get-Directories -BuildConfig $BuildConfig

            $resourceManagerModules = Get-ChildItem -Path $resourceManagerRootFolder -Directory -Filter Azs.*
            foreach ($module in $resourceManagerModules) {
                $targets += $module.FullName
            }
        }
        Write-Output -InputObject $targets
    }
}

#
#   Get the list of independent client modules, CRP, SRP, etc...
#
function Get-ClientModules
{
    [CmdletBinding()]
    param
    (
        [string]$BuildConfig,
        [string]$Scope,
        [bool]$PublishLocal,
        [string]$Profile = "Latest",
        [switch]$IsNetCore
    )

    PROCESS
    {
        Write-Verbose "Hi!, $PublishLocal"
        $targets = @()

        $packageFolder, $resourceManagerRootFolder = Get-Directories -BuildConfig $BuildConfig -IsNetCore:$IsNetCore

        if ((($Scope -eq 'All') -or $PublishLocal)) {
            if($IsNetCore) {
                $targets += "$resourceManagerRootFolder\AzureRM.Profile.Netcore"
            } else {
                $targets += "$resourceManagerRootFolder\AzureRM.Profile"
            }
        }

        if(-not $IsNetCore) {
            if (($Scope -eq 'All') -or ($Scope -eq 'AzureStorage')) {
                $targets += "$packageFolder\$buildConfig\Storage\Azure.Storage"
            }

            if ((($Scope -eq 'All') -or ($Scope -eq 'ServiceManagement')) -and ($Profile -ne "Stack")) {
                $targets += "$packageFolder\$buildConfig\ServiceManagement\Azure"
            }
        }

        $resourceManagerModules = Get-ChildItem -Path $resourceManagerRootFolder -Directory -Exclude Azs.*

        if ($Scope -eq 'All') {
            foreach ($module in $resourceManagerModules) {
                # filter out AzureRM.Profile which always gets published first
                # And "Azure.Storage" which is built out as test dependencies
                if (($module.Name -ne "AzureRM.Profile") -and ($module.Name -ne "Azure.Storage") -and ($module.Name -ne "AzureRM.Profile.Netcore")) {
                    $targets += $module.FullName
                }
            }
        } elseif (($Scope -ne 'AzureRM') -and ($Scope -ne "ServiceManagement") -and ($Scope -ne "AzureStorage") -and ($Scope -ne "Stack")) {
            $modulePath = Join-Path $resourceManagerRootFolder "AzureRM.$Scope"
            if (Test-Path $modulePath) {
                $targets += $modulePath
            } else {
                Write-Error "Can not find module with name $Scope to publish"
            }
        }
        Write-Verbose ($targets | Out-String)
        Write-Output -InputObject $targets
    }
}

#
#   Set the version of each dependecy.
#
function Set-StrictModuleDependencies
{
    [CmdletBinding()]
    param(
        [string]$Path
    )

    PROCESS
    {
        $manifest = Test-ModuleManifest -Path $Path
        $newModules = @()
        foreach ($module in $manifest.RequiredModules)
        {
            $newModules += (@{ModuleName = $module.Name; RequiredVersion= $module.Version})
        }

        if ($newModules.Count -gt 0)
        {
            Update-ModuleManifest -Path $Path -RequiredModules $newModules
        }
    }
}

#
#   Make the psm1 file a dependency.
#
function Add-PSM1Dependency
{
    [CmdletBinding()]
    param(
        [string]$Path,
        [switch]$IsNetCore
    )

    PROCESS
    {
        $file = Get-Item -Path $Path
        $manifestFile = $file.Name
        $psm1file = $manifestFile -replace ".psd1", ".psm1"
        Test-ModuleManifest -Path $Path | Out-Null
        if(-not $IsNetCore) {
            Update-ModuleManifest -Path $Path -RootModule $psm1file
        }
    }
}

#
#   Move required module dependencies.
#
function Remove-ModuleDependencies
{
    [CmdletBinding()]
    param(
        [string]$Path
    )

    PROCESS
    {
        $regex = New-Object System.Text.RegularExpressions.Regex "RequiredModules\s*=\s*@\([^\)]+\)"
        $content = (Get-Content -Path $Path) -join "`r`n"
        $text = $regex.Replace($content, "RequiredModules = @()")
        $text | Out-File -FilePath $Path
    }

}

#
#   Update licensing
#
function Update-NugetPackage
{
    [CmdletBinding()]
    param(
        [string]$BasePath,
        [string]$ModuleName,
        [string]$DirPath,
        [string]$NugetExe
    )

    PROCESS
    {
        $regex2 = "<requireLicenseAcceptance>false</requireLicenseAcceptance>"

        $relDir = Join-Path $DirPath -ChildPath "_rels"
        $contentPath = Join-Path $DirPath -ChildPath '`[Content_Types`].xml'
        $packPath = Join-Path $DirPath -ChildPath "package"
        $modulePath = Join-Path $DirPath -ChildPath ($ModuleName + ".nuspec")

        Remove-Item -Recurse -Path $relDir -Force
        Remove-Item -Recurse -Path $packPath -Force
        Remove-Item -Path $contentPath -Force

        $content = (Get-Content -Path $modulePath) -join "`r`n"
        $content = $content -replace $regex2, ("<licenseUrl>https://raw.githubusercontent.com/Azure/azure-powershell/dev/LICENSE.txt</licenseUrl>`r`n    <projectUrl>https://github.com/Azure/azure-powershell</projectUrl>`r`n    <requireLicenseAcceptance>true</requireLicenseAcceptance>")
        $content | Out-File -FilePath $modulePath -Force
        &$NugetExe pack $modulePath -OutputDirectory $BasePath
    }
}

#
#   Cleanup modules
#
function Update-RMModule
{
    [CmdletBinding()]
    param(
        [string]$Path,
        [string]$RepoLocation,
        [string]$TempRepo,
        [string]$TempRepoPath,
        [string]$NugetExe,
        [switch]$Admin
    )

    PROCESS
    {
        $moduleName = (Get-Item -Path $Path).Name
        $moduleManifest = $moduleName + ".psd1"
        $moduleSourcePath = Join-Path -Path $Path -ChildPath $moduleManifest
        $manifest = Set-StrictModuleDependencies $moduleSourcePath
        $manifest = Test-ModuleManifest -Path $moduleSourcePath
        Publish-Module -Path $Path -Repository $TempRepo -Force | Out-Null
        Write-Output "Changing to directory for module modifications $TempRepoPath"
        Push-Location $TempRepoPath
        try
        {
            $nupkgPath = Join-Path -Path . -ChildPath ($moduleName + "." + $manifest.Version.ToString() + ".nupkg")
            $zipPath = Join-Path -Path . -ChildPath ($moduleName + "." + $manifest.Version.ToString() + ".zip")
            $dirPath = Join-Path -Path . -ChildPath $moduleName
            $unzippedManifest = Join-Path -Path $dirPath -ChildPath ($moduleName + ".psd1")

            if (!(Test-Path -Path $nupkgPath))
            {
                throw "Module at $nupkgPath in $TempRepoPath does not exist"
            }

            Write-Output "Renaming package $nupkgPath to zip archive $zipPath"
            Rename-Item $nupkgPath $zipPath
            Write-Output "Expanding $zipPath"
            Expand-Archive $zipPath -DestinationPath $dirPath
            if( -not $Admin) {
                Write-Output "Adding PSM1 dependency to $unzippedManifest"
                Add-PSM1Dependency -Path $unzippedManifest
            }
            Write-Output "Removing module manifest dependencies for $unzippedManifest"
            Remove-ModuleDependencies -Path $unzippedManifest

            Remove-Item -Path $zipPath -Force
            Write-Output "Repackaging $dirPath"
            Update-NugetPackage -BasePath $TempRepoPath -ModuleName $moduleName -DirPath $dirPath -NugetExe $NugetExe
        }
        finally
        {
            Pop-Location
        }
    }
}

#
#   Push modules to repo.
#
function Publish-RMModule
{
    [CmdletBinding()]
    param(
        [string]$Path,
        [string]$ApiKey,
        [string]$TempRepoPath,
        [string]$RepoLocation,
        [string]$nugetExe
    )

    PROCESS
    {
        $moduleName = (Get-Item -Path $Path).Name
        $moduleManifest = $moduleName + ".psd1"
        $moduleSourcePath = Join-Path -Path $Path -ChildPath $moduleManifest
        $manifest = Test-ModuleManifest -Path $moduleSourcePath
        $nupkgPath = Join-Path -Path $TempRepoPath -ChildPath ($moduleName + "." + $manifest.Version.ToString() + ".nupkg")
        if (!(Test-Path -Path $nupkgPath))
        {
            throw "Module at $nupkgPath in $TempRepoPath does not exist"
        }

        Write-Output "Pushing package $moduleName to nuget source $RepoLocation"
        &$nugetExe push $nupkgPath $ApiKey -s $RepoLocation
        Write-Output "Pushed package $moduleName to nuget source $RepoLocation"
    }
}


#
#   Given a list of paths to modules create nugets
#
function Add-Modules
{
    [CmdletBinding()]
    param(
        [String[]]$ModulePaths,
        [switch]$Admin
    )
    PROCESS
    {
        foreach ($modulePath in $ModulePaths) {
            Write-Output $modulePath
            $module = Get-Item -Path $modulePath
            Write-Output "Updating $module module from $modulePath"
            Update-RMModule -Path $modulePath -RepoLocation $repositoryLocation -TempRepo $tempRepoName -TempRepoPath $tempRepoPath -nugetExe $nugetExe -Admin:$Admin
            Write-Output "Updated $module module"
        }
    }
}


if ([string]::IsNullOrEmpty($buildConfig))
{
    Write-Verbose "Setting build configuration to 'Release'"
    $buildConfig = "Release"
}

if ([string]::IsNullOrEmpty($repositoryLocation))
{
    Write-Verbose "Setting repository location to 'https://dtlgalleryint.cloudapp.net/api/v2'"
    $repositoryLocation = "https://dtlgalleryint.cloudapp.net/api/v2"
}

if ([string]::IsNullOrEmpty($Scope))
{
    Write-Verbose "Default scope to all"
    $Scope = 'All'
}

if ([string]::IsNullOrEmpty($nugetExe))
{
    Write-Verbose "Use default nuget path"
    $nugetExe =  "$PSScriptRoot\nuget.exe"
}

Write-Host "Publishing $Scope package(and its dependencies)"
Get-PackageProvider -Name NuGet -Force

$packageFolder = "$PSScriptRoot\..\src\Package"
if ($Profile -eq "Stack")
{
    $packageFolder = "$PSScriptRoot\..\src\Stack"
}

$publishToLocal = test-path $repositoryLocation
[string]$tempRepoPath = "$PSScriptRoot\..\src\package"
if ($publishToLocal)
{
    if ($Profile -eq "Stack"){
        $tempRepoPath = (Join-Path $repositoryLocation -ChildPath "stack")
    }
    else {
        $tempRepoPath = (Join-Path $repositoryLocation -ChildPath "package")

    }
}

$tempRepoName = ([System.Guid]::NewGuid()).ToString()
$repo = Get-PSRepository | Where-Object { $_.SourceLocation -eq $tempRepoPath }
if ($repo -ne $null) {
    $tempRepoName = $repo.Name
} else {
    Register-PSRepository -Name $tempRepoName -SourceLocation $tempRepoPath -PublishLocation $tempRepoPath -InstallationPolicy Trusted -PackageManagementProvider NuGet
}

$env:PSModulePath="$env:PSModulePath;$tempRepoPath"

try {
    Write-Output "Getting client modules..."
    $clientModules = Get-ClientModules -BuildConfig $buildConfig -Scope $Scope -PublishLocal:$publishToLocal -Profile $Profile -IsNetCore:$isNetCore
    Add-Modules -ModulePath $clientModules
    Write-Output  " "

    Write-Output "Getting admin modules..."
    $adminModules = Get-AdminModules -BuildConfig $BuildConfig -Scope $Scope -IsNetCore:$isNetCore
    Add-Modules -ModulePath $adminModules
    Write-Output  " "

    Write-Output "Getting rollup modules..."
    $rollupModules = Get-RollupModules -BuildConfig $BuildConfig -Scope $Scope -IsNetCore:$isNetCore
    Add-Modules -ModulePath $adminModules -Admin
    Write-Output  " "

    if (!$publishToLocal)
    {
        $modulePaths = $clientModules + $rollUpModules + $adminModules
        foreach ($modulePath in $modulePaths) {
            $module = Get-Item -Path $modulePath
            Write-Host "Pushing $module module from $modulePath"
            Publish-RMModule -Path $modulePath -ApiKey $apiKey -TempRepoPath $tempRepoPath -RepoLocation $repositoryLocation -nugetExe $nugetExe
            Write-Host "Pushed $module module"
        }
    }

}
finally
{
    Unregister-PSRepository -Name $tempRepoName
}
