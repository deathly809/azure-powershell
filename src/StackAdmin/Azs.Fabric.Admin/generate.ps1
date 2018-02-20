
$rpName = "fabric"
$name = "Fabric"
$location = Get-Location
$psswagger = "E:\github\PSswagger"
$module = "Module"
$namespace = "Microsoft.AzureStack.Management.$Name.Admin"
$assembly = "$namespace.dll"
$client = "$namespace.FabricAdminClient"

. ..\..\..\tools\GeneratePSSwagger.ps1 `
    -RPName $rpName `
    -Location $location `
    -Admin `
    -ModuleDirectory $module `
    -AzureStack `
    -PSSwaggerLocation $psswagger `
    -GithubAccount deathly809 `
    -GithubBranch azs.fabric.admin `
    -PredefinedAssemblies $assembly `
    -Name $name `
    -ClientTypeName $client