
$rpName = "update"
$location = pwd
$moduleName = "Update"

. ..\..\..\tools\GeneratePSSwagger.ps1 -RPName $rpName -Location $location -Name $moduleName -Admin -Repo deathly809 -Branch "azs.update.admin" -ClientName "Microsoft.AzureStack.Management.Update.Admin.UpdateAdminClient" -DLLName "Microsoft.AzureStack.Management.Update.Admin.dll" -PSSwaggerLocation "E:\github\PSswagger" -AzureStack