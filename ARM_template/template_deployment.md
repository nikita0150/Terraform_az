## 1. Using Azure portal - GUI
- Go to Azure Portal

- Search for Deploy a custom template

- Click Build your own template in the editor

- Paste your ARM JSON template

- Click Save

- Fill required parameters

- Select: Resource Group -> Region -> Click Review + Create → Create

## 2. Using Azure CLI

- Basic command 
    az deployment group create \
    --resource-group myResourceGroup \
    --template-file template.json \
    --parameters parameters.json

- For deploying at different level - 
    ____________________________________________________  
    | Scope            | Command                       |
    | ---------------- | ----------------------------- |
    | Resource Group   | `az deployment group create`  |
    | Subscription     | `az deployment sub create`    |
    | Management Group | `az deployment mg create`     |
    | Tenant           | `az deployment tenant create` |
     
## 3. Using powershell
- Login 
    Connect-AzAccount

- Deploy template 
   New-AzResourceGroupDeployment `
  -ResourceGroupName "rg-demo" `
  -TemplateFile "template.json"

## 4. Using Azure devops pipeline
- YAML -> 

    trigger:
    - main

    pool:
    vmImage: ubuntu-latest

    steps:

    - task: AzureResourceManagerTemplateDeployment@3
    inputs:
        deploymentScope: 'Resource Group'
        azureResourceManagerConnection: 'Azure-Service-Connection'
        subscriptionId: 'xxxx-xxxx-xxxx'
        action: 'Create Or Update Resource Group'
        resourceGroupName: 'rg-demo'
        location: 'East US'
        templateLocation: 'Linked artifact'
        csmFile: 'arm/template.json'
        csmParametersFile: 'arm/parameters.json'