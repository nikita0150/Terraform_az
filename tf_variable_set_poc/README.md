# 🧱 Terraform Cloud Infrastructure

## 📌 Overview

This repository contains Terraform configuration files that define and manage infrastructure resources using **Terraform Cloud** for remote state and CI/CD runs.

Terraform Cloud handles:
- Remote state management
- Plan & apply execution
- Variable management per workspace

---

## 🚀 Requirements

### Tools
- Terraform CLI (version ...+)
- Terraform Cloud account
- GitHub (or other VCS provider) connected to Terraform Cloud

### Terraform Cloud
Make sure you have:
- An Organization in Terraform Cloud
- A Workspace linked to this repository

---

## 🧠 Variables

Terraform Cloud supports two variable types:
1. **Terraform Variables** — used as input variables in `.tf` files  
2. **Environment Variables** — available as shell environment variables during runs


### 🧩 Terraform Variables (inputs)

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `region` | Cloud region to provision resources | string | `"us-east-1"` | no |
| `instance_type` | Type of instance to use | string | `"t3.micro"` | no |
| `project_name` | Identifier for project/team | string | *none* | yes |

> Define these variables either in Terraform Cloud **workspace variable UI**, or as `.auto.tfvars` if local.

### 🔐 Environment Variables

Set these in Terraform Cloud workspace under **Variables → Environment Variables**:

| Name | Description |
|------|-------------|
| `AWS_ACCESS_KEY_ID` | AWS API access key |
| `AWS_SECRET_ACCESS_KEY` | AWS API secret |
| `TF_VAR_db_password` | Database password passed as variable |
| `TF_LOG` | Enable detailed Terraform log output |

📌 Environment variables are NOT committed in VCS for security reasons.

---

=================================================

# variable set

A Variable Set in Terraform Cloud allows you to:

Define variables once

Share them across multiple workspaces

# Example:

You create a Variable Set called:

    azure-authentication

Inside it, you add:

    ARM_CLIENT_ID

    ARM_CLIENT_SECRET

    ARM_SUBSCRIPTION_ID

    ARM_TENANT_ID

Then you attach this Variable Set to:

    workspace-dev

    workspace-prod

    workspace-poc

Now all those workspaces share the same Azure credentials.

# No duplication. Clean. Professional.

