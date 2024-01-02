# How Which varaibles preceeds - terminal, default or tfvar for rg name
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
  client_id = "YOUR-VALUES-HERE"
  client_secret = "YOUR-VALUES-HERE"
  tenant_id = "YOUR-VALUES-HERE"
  subscription_id = "YOUR-VALUES-HERE"
}


 resource "azurerm_resource_group" "example" {
   name     = var.rg-name
   location = "West Europe"
 }
 
 resource "azurerm_public_ip" "example" {
   # count is a Meta Argument here
   count               = 3
   name                = "terraform-${count.index}"
   resource_group_name = azurerm_resource_group.example.name
   location            = var.location[count.index]
   allocation_method   = "Static"
   tags                = var.tags
 }
 output "ip" {
   # zipmap(key_list,value_list)
   value = zipmap(azurerm_public_ip.example[*].name, azurerm_public_ip.example[*].ip_address)
 }


/*
ZIPMAP combines two list functions
THIS DISPLAYS OUTPUT AS:
ip = {
      + terraform-0 = (known after apply)
      + terraform-1 = (known after apply)
      + terraform-2 = (known after apply)
    }

*/
