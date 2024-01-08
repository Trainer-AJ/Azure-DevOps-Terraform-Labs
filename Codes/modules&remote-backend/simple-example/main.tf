terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}

module "vnet" {
  source = "./modules"
  rg_name = "module-tf-rg"
  public_subnet_range = ["172.31.1.0/24", "172.31.5.0/24"]
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "private_subnet_id" {
  value = module.vnet.private_subnet_id
}

output "public_subnet_id" {
  value = module.vnet.public_subnet_id
}
