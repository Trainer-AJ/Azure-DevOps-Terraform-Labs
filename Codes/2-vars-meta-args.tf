
# ----------------------------------------------------
# LAB-2 : Variables and Meta Arguments 
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

provider "azurerm" {
  features {}
}

# ------------------ PROMPT FOR VARIABLE --------------

variable "location" {
  description = "give resource group location"
  type = string
}

resource "azurerm_resource_group" "first" {
  name     = "Dev-RG-1"
  location = var.location
  tags = {
    "Env" = "Dev"
  }
}

resource "azurerm_resource_group" "second" {
  name     = "UAT-RG-1"
  location = var.location
  tags = {
    "Env" = "UAT"
  }
}

# --------------------------- META ARGUMENTS ------------------------------------
data "azurerm_resource_group" "example-1" {
  name     = azurerm_resource_group.first.name
}

data "azurerm_resource_group" "example-2" {
  depends_on = [azurerm_resource_group.second]
  name       = "UAT-RG-1"
}

output "id" {
  value = " The First Resource group's name is ${azurerm_resource_group.first.name} & ID is ${data.azurerm_resource_group.example-1.id}"
}

output "RG2-id" {
  depends_on = [azurerm_resource_group.second]
  value      = data.azurerm_resource_group.example-2
}

# ------------- USING MAP DATA TYPE VARIABLE ---------------

variable "rg_details" {
  type = map(string)
  description = "create a tfvars or .auto.tfvars file with LIST or MAP values"
  default = {
    "name"  = "Map-RG"
  "region" = "West Europe"
  }
}

resource "azurerm_resource_group" "third" {
  name     = var.rg_details.name
  location = var.rg_details.region
}

# ----------------- USING LIST DATA TYPE VARIABLE ---------------

variable "rg_list" {
  type = list(string)
  default = ["List_RG", "Eastus"]
}


resource "azurerm_resource_group" "fourth" {
  name     = var.rg_list[0]
  location = var.rg_list[1]
}
# - --------------------- Count Parameter -----------------

variable "location_list" {
  default = ["East US", "Central India", "South India"]
}

resource "azurerm_resource_group" "fifth" {
  count    = 3
  name     = "count-${count.index}"
  location = var.location_list[count.index]
}