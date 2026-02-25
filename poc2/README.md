# Terraform Azure Project

## Overview
This project uses Terraform and Azure DevOps pipelines to provision Azure resources automatically.

## Components
- **Terraform Code:** Defines Azure resources like Resource Groups and storage accounts.
- **Azure DevOps Pipeline:** Automates Terraform commands (init, plan, apply) on code changes.
- **Self-Hosted Agent:** Windows machine that runs the pipeline.
- **Terraform Backend:** Azure Storage container stores Terraform state.

## Setup
1. Configure a self-hosted agent in Azure DevOps.
2. Install Terraform on the agent machine and ensure it's in PATH.
3. Create an Azure Service Connection in Azure DevOps (`Terraform`) with Contributor access.
4. Update `variables.tf` with your Azure resource details.
5. Push Terraform code to the repo.

## Pipeline
- Triggered on `main` branch.
- Steps:
  1. Install Terraform
  2. Terraform Init
  3. Terraform Plan
  4. Terraform Apply

## Architecture 

Azure DevOps Repo
  ├─ main.tf
  ├─ backend.tf
  └─ variables.tf
       │
       ▼
Azure DevOps Pipeline
  ├─ Terraform Installer
  ├─ Terraform Init
  ├─ Terraform Plan
  └─ Terraform Apply
       │
       ▼
Self-Hosted Agent (Windows)
  ├─ Terraform installed
  └─ PAT authentication
       │
       ▼
Azure Resources
  ├─ Resource Group
  ├─ Storage Account
  └─ Container (Terraform State)
  
=======================================================================================

