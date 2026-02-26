# Terraform Azure Project

## Overview
This project uses Terraform and Azure DevOps pipelines to provision Azure resources automatically.

## Components
- **Terraform Code:** Defines Azure resources like Resource Groups and storage accounts.
- **Azure DevOps Pipeline:** Automates Terraform commands (init, plan, apply) on code changes.
- **Self-Hosted Agent:** Linux VM machine that runs the pipeline.
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
  3. Terraform validate
  4. Terraform Plan
  5. Terraform Apply

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
  |-- Terraform Validate
  ├─ Terraform Plan
  └─ Terraform Apply
       │
       ▼
Self-Hosted Agent (Linux)
  ├─ Terraform installed
  └─ PAT authentication
       │
       ▼
Azure Resources
  ├─ Resource Group
  ├─ Storage Account
  └─ Container (Terraform State)
  
=======================================================================================

## 🐛 Issue: Self-Hosted Azure DevOps Agent Required Manual ./run.sh

# 🔍 Problem

After setting up a self-hosted agent on an Ubuntu VM in Microsoft Azure, the agent only worked when manually running:

   ./run.sh

Whenever: VM restarted/SSH session closed/User logged out /The agent stopped.

Additionally, while trying to install the agent as a service:

./svc.sh install

faced multiple errors:

Must not run with sudo

./svc.sh: command not found

Must run as sudo

azureagent is not in the sudoers file

🎯 Root Causes
1️⃣ Agent Was Running in Interactive Mode

The agent was started using ./run.sh, which only runs in the active terminal session.

It was not installed as a system service.

2️⃣ Wrong Directory

We tried running:

sudo ./svc.sh install

From /root directory, but svc.sh exists inside:

/home/azureagent/myagent
3️⃣ Missing Sudo Permission

The azureagent user was not part of the sudo group.

So when trying:

sudo ./svc.sh install

We got:

azureagent is not in the sudoers file
✅ Solution
Step 1 — Add azureagent to sudo group (as root)
usermod -aG sudo azureagent
Step 2 — Re-login to apply group changes
su - azureagent
Step 3 — Navigate to agent directory
cd ~/myagent
Step 4 — Install agent as a service
sudo ./svc.sh install
sudo ./svc.sh start
Step 5 — Verify
sudo systemctl status vsts.agent.*

Expected:

Active: active (running)