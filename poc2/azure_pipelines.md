trigger:
- main  #the pipeline will be triggered on every push to the main branch

pool:
  name: 'Default'

variables:
  azureServiceConnection: 'Terraform'  #name of the Azure service connection in Azure DevOps
  workingDir: '$(System.DefaultWorkingDirectory)/poc2' #path to the directory containing Terraform configuration files - Go to the pipeline's root repo folder
  System.Debug: 'true'  #this enables detailed logging for debugging purposes

steps:

# Checkout current repo (main branch), if is self it means it will check main branch by default!
- checkout: self

- script: | # this is for debugging  
    echo Current directory:
    cd 
    echo Listing repo root:
    dir
    echo Listing Terraform folder:
    dir "$(workingDir)"
  displayName: 'Verify Terraform Directory'

# Install Terraform
- task: TerraformInstaller@1
  displayName: 'Install Terraform'
  inputs:
    terraformVersion: 'latest'

# Terraform Init
- task: TerraformTaskV4@4
  displayName: 'Terraform Init'
  inputs:
    provider: 'azurerm'
    command: 'init'
    workingDirectory: '$(workingDir)'
    backendServiceArm: '$(azureServiceConnection)'
    backendAzureRMResourceGroupName: 'Panda_Prod'
    backendAzureRMStorageAccountName: 'storageacc235'
    backendAzureRMContainerName: 'tfstatefile'
    backendAzureRMKey: 'terraform.tfstate'

# Terraform Plan
- task: TerraformTaskV4@4
  displayName: 'Terraform Plan'
  timeoutInMinutes: 5
  inputs:
    provider: 'azurerm'
    command: 'plan'
    workingDirectory: '$(workingDir)'
    environmentServiceNameAzureRM: '$(azureServiceConnection)'

# Terraform Apply
- task: TerraformTaskV4@4
  displayName: 'Terraform Apply'
  inputs:
    provider: 'azurerm'
    command: 'apply'
    commandOptions: '-auto-approve'
    workingDirectory: '$(workingDir)'
    environmentServiceNameAzureRM: '$(azureServiceConnection)'