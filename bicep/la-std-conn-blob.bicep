
param blobServiceResourceGroup string = 'gb-int-other-services-rg'
param blobConnectionName string = 'AzureBlob_V2'
param blobAccountName string = 'gbintotherservicesst'
param location string = resourceGroup().location

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  scope: resourceGroup(blobServiceResourceGroup)
  name: blobAccountName
}

resource blobConnection 'Microsoft.Web/connections@2016-06-01' = {
  name: blobConnectionName
  location: location
  kind: 'V2'
  properties: {
    displayName: 'Azure Blob Connection'
    parameterValues: {
      accountName: storageAccount.name
      accessKey: storageAccount.listkeys().keys[0].value
    }
    api: {
      name: 'azureblob'
      displayName: 'Azure Blob Storage'
      description: 'Microsoft Azure Storage provides a massively scalable, durable, and highly available storage for data on the cloud, and serves as the data storage solution for modern applications. Connect to Blob Storage to perform various operations such as create, update, get and delete on blobs in your Azure Storage account.'
      iconUri: 'https://connectoricons-prod.azureedge.net/releases/v1.0.1683/1.0.1683.3685/azureblob/icon.png'
      brandColor: '#804998'
      id: '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Web/locations/${location}/managedApis/azureblob'
      type: 'Microsoft.Web/locations/managedApis'
    }
    testLinks: [
      {
        requestUri: 'https://management.azure.com:443/subscriptions/${subscription().subscriptionId}/resourceGroup/${resourceGroup().id}/providers/Microsoft.Web/connections/${blobConnectionName}/extensions/proxy/testconnection?api-version=2016-06-01'
        method: 'get'
      }
    ]
  }
}

output apiConnectionUrl string = blobConnection.properties.connectionRuntimeUrl
output apiConnectionName string = blobConnection.name
