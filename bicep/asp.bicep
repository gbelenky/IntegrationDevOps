param serverfarms_gb_int1_dev_std_la_asp_name string = 'gb-int1-dev-std-la-asp'

resource serverfarms_gb_int1_dev_std_la_asp_name_resource 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: serverfarms_gb_int1_dev_std_la_asp_name
  location: 'West Europe'
  sku: {
    name: 'WS1'
    tier: 'WorkflowStandard'
    size: 'WS1'
    family: 'WS'
    capacity: 1
  }
  kind: 'elastic'
  properties: {
    perSiteScaling: false
    maximumElasticWorkerCount: 20
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}
