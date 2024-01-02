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
  alias           = "azure-pass"
  client_id = "YOUR-VALUES-HERE"
  client_secret = "YOUR-VALUES-HERE"
  tenant_id = "YOUR-VALUES-HERE"
  subscription_id = "YOUR-VALUES-HERE"
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

# ---------------------------------------------------------------
data "azurerm_resource_group" "example-1" {
  provider = azurerm.azure-pass
  name     = azurerm_resource_group.first.name
}

data "azurerm_resource_group" "example-2" {
  depends_on = [azurerm_resource_group.second]
  provider   = azurerm.azure-pass
  name       = "UAT-RG-1"
}

output "id" {
  value = " The First Resource group's name is ${azurerm_resource_group.first.name} & ID is ${data.azurerm_resource_group.example-1.id}"
}

output "RG2-id" {
  depends_on = [azurerm_resource_group.second]
  value      = data.azurerm_resource_group.example-2
}