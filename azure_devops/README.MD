## Self-Hosted Agent, Service Connection & Service Hooks

This document explains key Azure DevOps concepts:

- Self-Hosted Agent  
- Service Connection  
- Service Hooks  

Platform: Azure DevOps

---

# 1️⃣ Self-Hosted Agent

## 📌 What is a Self-Hosted Agent?

A **Self-Hosted Agent** is a machine (VM, physical server, or on-prem server) that you configure to run Azure DevOps pipelines.

Instead of using Microsoft-hosted agents, you manage and maintain your own build agent.

---

## 🏗 Why Use a Self-Hosted Agent?

Use self-hosted agents when:

- You need custom software installed
- You require access to private/internal network resources
- You want faster builds (no fresh VM every run)
- You have compliance/security requirements
- You need specific hardware (GPU, high memory, etc.)

---

## 🆚 Microsoft-Hosted vs Self-Hosted

| Feature | Microsoft-Hosted | Self-Hosted |
|----------|------------------|-------------|
| Setup | No setup required | Manual setup required |
| Maintenance | Managed by Microsoft | You manage it |
| Cost | Limited free minutes | Your infrastructure cost |
| Custom Software | Limited | Full control |
| Private Network Access | No | Yes |

---

## ⚙️ How It Works

1. Install agent software on your machine.
2. Register agent with Azure DevOps.
3. Agent polls Azure DevOps for jobs.
4. Pipeline runs on that machine.

---

## 🛠 Setup Steps (High-Level)

1. Navigate to: Organization Settings → Agent Pools
 
2. Create or select an Agent Pool.

3. Download agent package for:
- Windows
- Linux
- macOS

4. Configure agent:
./config.sh

5. Run agent
./run.sh

---
## Self hosted agent 
trigger:
- main

pool:
  name: Default   # or your pool name

steps:
- script: |
    echo Agent is working!
    hostname

---

# 📌 What is a Service Connection?

A **Service Connection** in Azure DevOps allows pipelines to securely connect to external services such as cloud providers, container registries, repositories, or APIs.

It securely stores authentication details required for deployments and integrations.

In simple terms:

> Service Connection = Secure bridge between Azure DevOps and external systems.

---

# 🏗 Why Service Connection is Required?

Without a Service Connection:

- Pipelines cannot deploy to cloud resources
- No authentication to Azure, AWS, or Kubernetes
- Cannot push images to Docker registry
- Cannot integrate with external APIs

It enables secure automation in CI/CD pipelines.

---

# 🔗 Common Types of Service Connections

Azure DevOps supports multiple service connection types:

- Azure Resource Manager
- Docker Registry
- Kubernetes
- GitHub
- AWS
- Generic REST API
- Service Fabric
- SSH

---

# 🔐 Authentication Methods

Depending on the service type, authentication can be done using:

- Service Principal (Azure)
- Managed Identity
- Personal Access Token (PAT)
- OAuth
- Access Keys
- Username & Password
- SSH Key

---

# ⚙️ Where to Configure Service Connection?

Navigate to: Project Settings → Service Connections
From there you can:

- Create new connection
- Manage permissions
- Restrict access to specific pipelines
- Grant access to all pipelines

---

# 🛠 Example: Azure Service Connection Setup (High-Level)

1. Go to Project Settings  
2. Click **Service Connections**  
3. Click **New Service Connection**  
4. Select **Azure Resource Manager**  
5. Choose authentication method  
6. Provide subscription details  
7. Grant pipeline permissions  
8. Save  

---

# 🧪 Example Usage in YAML Pipeline

.yaml - 
- task: AzureWebApp@1
  inputs:
    azureSubscription: 'My-Service-Connection'
    appName: 'my-webapp'

---

# 📌 What are Service Hooks?

**Service Hooks** allow Azure DevOps to send real-time notifications to external services whenever specific events occur inside a project.

In simple terms:

> Service Hooks = Event-based notifications from Azure DevOps to external systems.

They help integrate Azure DevOps with chat tools, automation tools, and third-party services.

---

# 🏗 Why Service Hooks are Required?

Service Hooks enable:

- Real-time build notifications
- Integration with collaboration tools
- Automation triggers in external systems
- Syncing work items with other platforms

Without Service Hooks, you would need manual updates or custom scripts.

---

# 📡 How Service Hooks Work

1. An event occurs inside Azure DevOps  
   (e.g., build completed, pull request created)
2. Azure DevOps detects the event.
3. A Service Hook subscription is triggered.
4. A payload (JSON) is sent to the configured external service.
5. The external system processes the event.

---

# 🎯 Common Events That Can Trigger Service Hooks

- Code pushed
- Pull request created or updated
- Build completed
- Release deployed
- Work item created or updated
- Pipeline failed

---

# 🔗 Supported Services

Azure DevOps can send Service Hooks to:

- Slack
- Microsoft Teams
- Jenkins
- Trello
- Webhooks (Generic REST endpoint)
- Azure Functions
- Custom APIs

---

# ⚙️ Where to Configure Service Hooks?

Navigate to: Project setting --> service hooks


From there you can:

- Create new subscription
- Select event type
- Apply filters
- Choose target service
- Test and save

---

# 🛠 Steps to Create a Service Hook

1. Go to **Project Settings**
2. Click **Service Hooks**
3. Click **Create Subscription**
4. Choose the service (e.g., Slack)
5. Select event (e.g., Build completed)
6. Add filters (optional)
7. Configure target endpoint
8. Test connection
9. Save

---

# 🔎 Filtering Options

Service Hooks allow event filtering such as:

- Specific branch
- Specific pipeline
- Specific repository
- Specific work item type
- Specific project

This prevents unnecessary notifications.

---

# 📦 Example: Webhook Payload (Simplified)

When a build completes, Azure DevOps sends a JSON payload like:

```json
{
  "eventType": "build.complete",
  "resource": {
    "status": "succeeded",
    "buildNumber": "2026.02.25.1"
  }
}