param connectionName string
param tenantId string
param principalId string
param location string = resourceGroup().location

resource accessPolicy 'Microsoft.Web/connections/accessPolicies@2016-06-01' = {
  name: '${connectionName}/${principalId}'
  location: location
  properties: {
    principal: {
      type: 'ActiveDirectory'
      identity: {
        tenantId: tenantId
        objectId: principalId
      }
    }
  }
}
