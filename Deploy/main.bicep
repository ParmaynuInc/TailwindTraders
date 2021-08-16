param sku string = 'Standard'
param skuCode string = 'S1'
param registrySku string = 'Standard'
param workerSize int = 1
param dockerRegistryUrl string = 'https://index.docker.io'
param dockerimage string = 'msfttailwindtraders/tailwindtraderswebsite:latest'
param apiBaseUrl string = 'https://backend.tailwindtraders.com/'

var website_name_var = 'tailwindtraders${uniqueString(resourceGroup().id)}'
var plan_name_var = 'ttappserviceplan${uniqueString(resourceGroup().id)}'
var acr_name_var = 'ttacr${uniqueString(resourceGroup().id)}'
var deployment_slot_name = 'staging'

resource acr_name 'Microsoft.ContainerRegistry/registries@2017-10-01' = {
  name: acr_name_var
  location: resourceGroup().location
  sku: {
    name: registrySku
  }
  properties: {
    adminUserEnabled: true
  }
}

resource website_name 'Microsoft.Web/sites@2018-02-01' = {
  name: website_name_var
  location: resourceGroup().location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: dockerRegistryUrl
        }
        {
          name: 'ApiUrl'
          value: '${apiBaseUrl}/webbff/v1'
        }
        {
          name: 'ApiUrlShoppingCart'
          value: '${apiBaseUrl}/cart-api'
        }
      ]
      appCommandLine: ''
      linuxFxVersion: 'DOCKER|${dockerimage}'
    }
    serverFarmId: plan_name.id
  }
}

resource deployment_slot 'Microsoft.Web/sites/slots@2021-01-15' = {
  name: deployment_slot_name
  location: resourceGroup().location
  properties:{
    enabled: true
    serverFarmId: plan_name.id
  }
  parent: website_name
}

resource plan_name 'Microsoft.Web/serverfarms@2016-09-01' = {
  name: plan_name_var
  location: resourceGroup().location
  sku: {
    tier: sku
    name: skuCode
  }
  kind: 'linux'
  properties: {
    name: plan_name_var
    targetWorkerSizeId: workerSize
    targetWorkerCount: 1
    reserved: true
  }
}

output web string = website_name_var
output acr string = acr_name_var
