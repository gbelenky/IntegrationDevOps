param logicAppName string = 'myLogicAppwithConnections'
param cognitiveServicesAccountResourceGroup string = 'gb-int-other-services-rg'
param cvConnectionName string = 'cognitiveservicescomputervision'
param cvAccountName string = 'gb-int-other-services-cv'

resource cognitiveServicesAccount 'Microsoft.CognitiveServices/accounts@2021-04-30' existing = {
  scope: resourceGroup(cognitiveServicesAccountResourceGroup)
  name: cvAccountName
}

resource apiConnectionComputerVision 'Microsoft.Web/connections@2016-06-01' = {
  name: cvConnectionName
  location: resourceGroup().location
  kind: 'V2'
  id: '${subscription().id}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Web/connections/${cvConnectionName}'
  properties: {
    displayName: 'Computer Vision API Connection'
    parameterValueSet: {
      name: 'keyBasedAuth'
      values: {
        siteUrl: {
          value: 'https://${resourceGroup().location}.api.cognitive.microsoft.com'
        }
        apiKey: {
          value: listKeys(cognitiveServicesAccount.id, '2021-04-30').key1
        }
      }
    }
    api: {
      name: 'cognitiveservicescomputervision'
      id: '${subscription().id}/providers/Microsoft.Web/locations/${resourceGroup().location}/managedApis/cognitiveservicescomputervision'
      displayName: 'Computer Vision API'
      description: 'Extract rich information from images to categorize and process visual data—and protect your users from unwanted content with this Azure Cognitive Service.'
      iconUri: 'https://connectoricons-prod.azureedge.net/releases/v1.0.1680/1.0.1680.3652/cognitiveservicescomputervision/icon.png'
      brandColor: '#1267AE'
      category: 'Standard'
    }
  }
}

output apiConnectionUrl string = apiConnectionComputerVision.properties.connectionRuntimeUrl
output apiConnectionName string = apiConnectionComputerVision.name
