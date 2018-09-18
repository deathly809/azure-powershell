
using System.CodeDom;
//using System.Diagnostics.Eventing.Reader;
using System.Text;
using Microsoft.Azure.Management.Storage;
using Microsoft.Azure.Management.Storage.Models;
using System.Linq;

namespace Microsoft.WindowsAzure.Commands.Common.Storage
{
    using System;
    using Microsoft.WindowsAzure.Commands.Utilities.Common;
    using Microsoft.WindowsAzure.Commands.Common.Storage;
    using Microsoft.WindowsAzure.Storage;
    using Microsoft.WindowsAzure.Storage.Auth;
    using Microsoft.WindowsAzure.Storage.Blob;
    using Microsoft.WindowsAzure.Storage.Table;
    using  Arm = Microsoft.Azure.Management.Storage;
    using System.Text.RegularExpressions;

    public class StorageUtilities
    {
        /// <summary>
        /// Creates https endpoint from the given endpoint.
        /// </summary>
        /// <param name="endpointUri">The endpoint uri.</param>
        /// <returns>The https endpoint uri.</returns>
        public static Uri CreateHttpsEndpoint(string endpointUri)
        {
            UriBuilder builder = new UriBuilder(endpointUri) { Scheme = "https" };
            string endpoint = builder.Uri.GetComponents(
                UriComponents.AbsoluteUri & ~UriComponents.Port,
                UriFormat.UriEscaped);

            return new Uri(endpoint);
        }

        /// <summary>
        /// Create a cloud storage account using an ARM storage management client
        /// </summary>
        /// <param name="storageClient">The client to use to get storage account details.</param>
        /// <param name="resourceGroupName">The resource group contining the storage account.</param>
        /// <param name="accountName">The name of the storage account.</param>
        /// <returns>A CloudStorageAccount that can be used by windows azure storage library to manipulate objects in the storage account.</returns>
        public static CloudStorageAccount GenerateCloudStorageAccount(Arm.IStorageManagementClient storageClient,
            string resourceGroupName, string accountName)
        {
            if (!TestMockSupport.RunningMocked)
            {
                var storageServiceResponse = storageClient.StorageAccounts.GetProperties(resourceGroupName, accountName);
                Uri blobEndpoint = new Uri(storageServiceResponse.PrimaryEndpoints.Blob);
                Uri queueEndpoint = new Uri(storageServiceResponse.PrimaryEndpoints.Queue);
                Uri tableEndpoint = new Uri(storageServiceResponse.PrimaryEndpoints.Table);
                Uri fileEndpoint = new Uri(storageServiceResponse.PrimaryEndpoints.File);

                return new CloudStorageAccount(
                    GenerateStorageCredentials(storageClient, resourceGroupName, accountName),
                    blobEndpoint,
                    queueEndpoint,
                    tableEndpoint,
                    fileEndpoint);
            }
            else
            {
                return new CloudStorageAccount(
                    new StorageCredentials(accountName,
                        Convert.ToBase64String(Encoding.UTF8.GetBytes(Guid.NewGuid().ToString()))),
                    new Uri(string.Format("https://{0}.blob.core.windows.net", accountName)),
                    new Uri(string.Format("https://{0}.queue.core.windows.net", accountName)),
                    new Uri(string.Format("https://{0}.table.core.windows.net", accountName)),
                    new Uri(string.Format("https://{0}.file.core.windows.net", accountName)));
            }
        }

        /// <summary>
        /// Create a cloud storage account using a service management storage client
        /// </summary>
        /// <param name="storageClient">The client to use to get storage account details.</param>
        /// <param name="accountName">The name of the storage account.</param>
        /// <returns>A CloudStorageAccount that can be used by windows azure storage library to manipulate objects in the storage account.</returns>
        public static CloudStorageAccount GenerateCloudStorageAccount(IStorageManagementClient storageClient, string accountName)
        {
            if (!TestMockSupport.RunningMocked)
            {
                var storageAccounts= storageClient.StorageAccounts.List();
                var storageServiceResponse = storageAccounts.Where((sa) => sa.Name.Equals(accountName)).First();

                Uri fileEndpoint = null;
                Uri blobEndpoint = null;
                Uri queueEndpoint = null;
                Uri tableEndpoint = null;
                
                var file = storageServiceResponse.PrimaryEndpoints.File;
                if (String.IsNullOrEmpty(file)) {
                    fileEndpoint= StorageUtilities.CreateHttpsEndpoint(file);
                }

                var queue = storageServiceResponse.PrimaryEndpoints.Queue;
                if (String.IsNullOrEmpty(queue)) {
                    queueEndpoint = StorageUtilities.CreateHttpsEndpoint(queue);
                }

                var table = storageServiceResponse.PrimaryEndpoints.Table;
                if (String.IsNullOrEmpty(table)) {
                    tableEndpoint= StorageUtilities.CreateHttpsEndpoint(table);
                }

                var blob = storageServiceResponse.PrimaryEndpoints.Blob;
                if (String.IsNullOrEmpty(blob)) {
                    blobEndpoint = StorageUtilities.CreateHttpsEndpoint(blob);
                }
                
                return new CloudStorageAccount(
                    GenerateStorageCredentials(storageClient, storageServiceResponse.Name),
                    blobEndpoint,
                    queueEndpoint,
                    tableEndpoint,
                    fileEndpoint);
            }
            else
            {
                return new CloudStorageAccount(
                    new StorageCredentials(accountName,
                        Convert.ToBase64String(Encoding.UTF8.GetBytes(Guid.NewGuid().ToString()))),
                    new Uri(string.Format("https://{0}.blob.core.windows.net", accountName)),
                    new Uri(string.Format("https://{0}.queue.core.windows.net", accountName)),
                    new Uri(string.Format("https://{0}.table.core.windows.net", accountName)),
                    new Uri(string.Format("https://{0}.file.core.windows.net", accountName)));
            }
       }

        /// <summary>
        /// Create storage credentials for the given account
        /// </summary>
        /// <param name="storageClient">The ARM storage management client.</param>
        /// <param name="resourceGroupName">The resource group containing the storage account.</param>
        /// <param name="accountName">The storage account name.</param>
        /// <returns>Storage credentials for the given account.</returns>
        public static StorageCredentials GenerateStorageCredentials(Arm.IStorageManagementClient storageClient,
            string resourceGroupName, string accountName)
        {
            if (!TestMockSupport.RunningMocked)
            {
                var storageKeysResponse = storageClient.StorageAccounts.ListKeys(resourceGroupName, accountName);
                return new StorageCredentials(accountName,
                    storageKeysResponse.Keys[0].Value);
            }
            else
            {
                return new StorageCredentials(accountName,
                    Convert.ToBase64String(Encoding.UTF8.GetBytes(Guid.NewGuid().ToString())));
            }
        }

        /// <summary>
        /// Create storage credentials for the given account
        /// </summary>
        /// <param name="storageClient">The RDFE storage management client.</param>
        /// <param name="accountName">The storage account name.</param>
        /// <returns>Storage credentials for the given account.</returns>
         public static StorageCredentials GenerateStorageCredentials(IStorageManagementClient storageClient,
            string accountName)
        {
            if (!TestMockSupport.RunningMocked)
            {
                var storageAccounts = storageClient.StorageAccounts.List();
                var storageServiceResponse = storageAccounts.Where((sa) => sa.Name.Equals(accountName)).First();
                var resourceGroupName = GetResourceGroupFromId(storageServiceResponse.Id);

                var storageKeysResponse = storageClient.StorageAccounts.ListKeys(resourceGroupName, accountName);
                return new StorageCredentials(accountName,
                    storageKeysResponse.Keys[0].Value);
            }
            else
            {
                return new StorageCredentials(accountName,
                    Convert.ToBase64String(Encoding.UTF8.GetBytes(Guid.NewGuid().ToString())));
            }
        }

        internal static string GetResourceGroupFromId(string id) {
            var matcher = new Regex("/subscriptions/([^/]+)/resourceGroups/([^/]+)/providers/(\\w+)");
            var result = matcher.Match(id);
            if (!result.Success || result.Groups == null || result.Groups.Count < 3) {
                throw new InvalidOperationException(string.Format("Cannot find resource group name and storage account name from resource identity {0}", id));
            }
            return result.Groups[2].Value;
        }
    }
}
