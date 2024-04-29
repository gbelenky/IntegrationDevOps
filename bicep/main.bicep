targetScope = 'subscription'

param projectName string
param region string
param environmentName string

resource projectRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: format('{0}-{1}-rg', projectName, environmentName)
  location: region
}

module functionApp 'fa.bicep' = {
  name: 'functionAppModule'
  params: {
    functionAppName: format('{0}-{1}-fa', projectName, environmentName)
    location: projectRG.location
  }
  scope: resourceGroup(projectRG.name)
}

module logicApp 'la-cons.bicep' = {
  name: 'logicAppModuleConsumption'
  params: {
    logicAppName: format('{0}-{1}-cons-la', projectName, environmentName)
    location: projectRG.location
  }
  scope: resourceGroup(projectRG.name)
}

module logicAppStd 'la-std.bicep' = {
  name: 'logicAppModuleStandard'
  params: {
    logicAppName: format('{0}-{1}-std-la', projectName, environmentName)
    location: projectRG.location
  }
  scope: resourceGroup(projectRG.name)
}


output systemAssignedIdentityObjectId string = logicAppStd.outputs.systemAssignedIdentityObjectId
output systemAssignedIdentityPrincipalId string = logicAppStd.outputs.systemAssignedIdentityTenantId

