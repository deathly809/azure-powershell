
$rpName = "compute"
$location = pwd
$moduleName = "compute"
$namespace = "Microsoft.AzureStack.Management.Compute.Admin"
$clientName = "ComputeAdminClient"
$client = "$namespace.$clientName"
$dll = "$namespace.dll"
. ..\..\..\tools\GeneratePSSwagger.ps1 -RPName $rpName -Location $location -Name $moduleName -Admin -AzureStack -PSSwaggerLocation E:\github\PSswagger -Repo deathly809 -Branch azs.compute.admin -ClientName $client -DLLName $dll 