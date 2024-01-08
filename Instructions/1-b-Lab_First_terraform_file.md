---
lab:
    title: 'Intro to IaC - Creating Resource Groups'
    module: 'Module 2: Terraform basics'
---

# Lab Requirements:
Follow **[Lab-1](https://trainer-aj.github.io/Azure-DevOps-Terraform-Labs/Instructions/0-Lab_Setup_Env.html)** to setup things. 

# Lab Task:
**TERRAFORM DOC TO FOLLOW:** [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)
1. **Authenticate Terraform to Azure using service principal**
2. **Create two Azure Resource Groups:**
   
| Resource group Name | Location | Tag |
| ------------------| --------| ------|
| Dev-RG-1 | East US| Env = Dev |
| UAT-RG-1| West Europe| Env = UAT |

3. **Verify In Azure Portal** 
4. **Destroy The Resources**
5. **(OPTIONAL) Repeat same process by AUTHENTICATING USING AZURE CLI to Replace the hard Coded Values of secret values.**

## Instructions
### 1. Authenticate Terraform to Azure using service principal
1. Open terminal and verify Azure CLI installation using : `az --version`
2. Run `az login` command
3. Create a service Principal In Azure Using below Command:
```sh
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/Your-Subscription-ID-Here" > creds.txt
```
4. Open the Newly created `creds.txt` file to see your credentials.
   
### 2. Create two Azure Resource Groups:
1. Create a `main.tf` file like below:
   
```tf
# ----------------------------------------------------
# LAB: 1 SetUp Terraform 
# AUTHOR: Ananay Ojha
# ---------------------------------------------------
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
  # required_version = "value"
}

# AFter AZ Login command, Create a service Principal In Azure Using below Command
# az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/20000000-0000-0000-0000-000000000000"

provider "azurerm" {
  # Configuration options
  features {}
# NOTE : ADD AUTHENTICATION DETAILS HERE {DIY}
}

# ----------------------------------------------
# Now You Can Create Resources Here

# CREATE A RESOURCE GROUP

resource "azurerm_resource_group" "first" {
  provider = azurerm.azure-pass
  name     = "Dev-RG-1"
  location = "EastUS"
  tags = {
    "Env" = "Dev"
  }
}

resource "azurerm_resource_group" "second" {
  provider = azurerm.azure-pass
  name     = "UAT-RG-1"
  location = "Central India"
  tags = {
    "Env" = "UAT"
  }
}

```
2. Run `terraform init`
3. run `terraform plan`
4. run `terraform apply` enter `YES` when asked for confirmation

### 3. Verify In Azure Portal 
1. Login to `https://portal.azure.com/`
2. Search for Resource Groups
3. Verify The Creation of resources by Terraform 

### 4. Destroy The Resources
```sh
terraform destroy --auto-approve
```

### 5. (OPTIONAL) AUTHENTICATING USING AZURE CLI
- DO IT YOURSELF :)
- This helps you to research and reflect back on your learnings






