
$rpName = "commerce"
$name = "Commerce"
$location = Get-Location
$psswagger = "E:\github\PSswagger"
$module = "TestModule"
$namespace = "Microsoft.AzureStack.Management.$Name.Admin"
$assembly = "$namespace.dll"
$client = "$namespace.CommerceAdminClient"

. ..\..\..\tools\GeneratePSSwagger.ps1 `
    -RPName $rpName `
    -Location $location `
    -Admin `
    -ModuleDirectory $module `
    -AzureStack `
    -PSSwaggerLocation $psswagger `
    -GithubAccount deathly809 `
    -GithubBranch azs.$rpname.admin `
    -PredefinedAssemblies $assembly `
    -Name $name `
    -ClientTypeName $client