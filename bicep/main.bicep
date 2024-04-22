targetScope = 'subscription'

param projectName string
param resourceGroupLocation string
param environmentName string

resource projectRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: format('{0}-{1}-rg', projectName, environmentName)
  location: resourceGroupLocation
}

module logicApp 'la.bicep' = {
  name: 'logicAppModule'
  params: {
    logicAppName: format('{0}-{1}-la', projectName, environmentName)
    location: projectRG.location
  }
  scope: resourceGroup(projectRG.name)
}

module functionApp 'fa.bicep' = {
  name: 'functionAppModule'
  params: {
    functionAppName: format('{0}-{1}-fa', projectName, environmentName)
    location: projectRG.location
  }
  scope: resourceGroup(projectRG.name)
}


output newRGResourceId string = projectRG.id

