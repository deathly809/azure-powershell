
$rpName = "keyvault"
$location = pwd
$moduleName = "KeyVault"
$namespace = "Microsoft.AzureStack.Management.KeyVault.Admin"
$clientName = "KeyVaultAdminClient"
$client = "$namespace.$clientName"
$dll = "$namespace.dll"
. ..\..\..\tools\GeneratePSSwagger.ps1 -RPName $rpName -Location $location -Name $moduleName -Admin -AzureStack -PSSwaggerLocation E:\github\PSswagger -Repo deathly809 -Branch azs.keyvault.admin -ClientName $client -DLLName $dll 