.terraform file :

What it is:
.terraform is a hidden folder automatically created by Terraform after terraform init.

Where it lives:
In your root module folder (same as main.tf, variables.tf, etc.)

What it contains:

Provider plugins – downloaded binaries (e.g., azurerm)

Module cache – any modules Terraform fetched from registry

Lock files – like .terraform.lock.hcl to lock provider versions

You don’t write this manually – Terraform manages it.

Purpose:
Ensures consistent provider versions and module downloads, so Terraform knows exactly what code to use.

=================================================================

Terraform block: 

🔹 What It Does

Defines:

Required Terraform version

Required provider versions

🔹 Why Important?

Prevents version conflicts

Ensures reproducibility

==============================================================

Modules block: 

🔹 What It Does

Reuses a group of resources

Creates abstraction layer

Makes project scalable

🔹 Why Use Modules?

Reusability

Clean structure

Separation of concerns

🔹 Architecture

Root Module
   ├── provider
   ├── locals
   ├── variables
   └── module "vm"

Child Module
   ├── resources
   ├── variables
   └── outputs

=================================================================================

Locals block :

locals is used to define reusable expressions inside a module.

Think of it like:

📌 A temporary variable inside Terraform
📌 Used to avoid repetition
📌 Used to centralize logic

=================================================================

Output block :

🔹 What It Does

Displays values after apply - 

Exposes module outputs

🔹 Used For

Public IP

VM ID

Resource IDs

==================================================================
Provider block :

🔹 What It Does

Tells Terraform which cloud/platform to use.

Configures authentication & connection to that platform.

🔹 In Your Case

azurerm → Azure Resource Manager provider.

Connects Terraform to Azure subscription.

🔹 Important Points

Defined only in root module

Can use:

Azure CLI login

Service Principal

Environment variables (ARM_*)

Without provider → Terraform doesn’t know where to create resources.

=====================================================================

Features {} azure specific 

Required by AzureRM provider.

Enables internal provider features.

Without it → provider fails.

======================================================================

🔹 What is terraform.tfvars?

A .tfvars file is used to assign values to variables.

Remember:

variables.tf → defines variables

.tfvars → gives values to those variables

=====================================================================

variable block :

🔹 What It Does

Defines input values

Makes code reusable & dynamic

🔹 Key Concept

Variables = External input to module

===================================================================

Resource block :

🔹 What It Does

Actually creates infrastructure

The main building block

===============================================================

Complete big picture 

Provider  → connects to Azure
Variables → input values
Locals    → computed values
Resources → create infrastructure
Modules   → organize infrastructure
Outputs   → expose information
Terraform block → version control

===============================================================