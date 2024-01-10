---
lab:
    title: 'Using Terraform Modules with Remote Backend'
    module: 'Module 8: Advance Terraform'
---

## Task:

## 1. Create terraform module
1. crate a folder called as `network`

Your terraform Module should create: 
- Your Module Should accept Resource Group `name` & `location` as variable 
- A Resource Group
- 1 VNet 
- 1 Subnet inside that VNet


## Your Created Should look similar to : 

1. Create a main.tf file inside `network` folder cerated above

```tf
resource "azurerm_resource_group" "this" {
  name     = var.rg_name
  location = var.rg_location
  tags = {
    "owner" = "Ananay"
  }
}

# Create VNET
resource "azurerm_virtual_network" "this" {
  name                = "terraform-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

# 1 Subnets:

resource "azurerm_subnet" "subnet" {
  depends_on = [ azurerm_virtual_network.this ]
  name                 = "private-subnet-1"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  # if you don't add [] here it says ERROR: list of string required 
  address_prefixes     = ["10.0.99.0/24"]
}

output "rg-name" {
    value = azurerm_resource_group.this.name
}

output "rg-location" {
  value = azurerm_resource_group.this.location
}

output "subnet-id" {
    value = azurerm_subnet_subnet.id
}

```

## 2. Create a Main.tf file that calls Above module and Add remote backend
- A route table that has next hop for `0.0.0.0/0` as `NONE` 
- Your Module should Output The created resource group's name and region

Create a `main.tf` like below:

```tf

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
  features {

  }
}

module "vnet" {
  source = "./network"
  rg_name = "module-tf-rg"
  rg_location = "centralindia"
  
}

terraform {
  backend "azurerm" {
    resource_group_name  = "YOUR-VALUES-HERE"
    storage_account_name = "YOUR-VALUES-HERE"
    container_name       = "YOUR-VALUES-HERE"
    key                  = "YOUR-VALUES-HERE"
  }
}

# Create Route Table
resource "azurerm_route_table" "private-route-table" {
  name                          = "this-route-table"
  location                      = module.vnet.rg-location
  resource_group_name           = module.vnet.rg-name
  disable_bgp_route_propagation = false

  route {
    name           = "intra-vnet"
    address_prefix = ["10.0.0.0/0"]
    next_hop_type  = "VnetLocal"
  }
    
}

resource "azurerm_route" "private-routes" {
  name                = "no-to-internet"
  resource_group_name = module.vnet.rg-name
  route_table_name    = azurerm_route_table.private-route-table.name
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "None"
}

resource "azurerm_subnet_route_table_association" "add-2-private" {
  subnet_id      = module.vnet.subnet-id
  route_table_id = azurerm_route_table.private-route-table.id
}

```

2. Run Terraform commands:

```sh
terraform init
terraform plan 
terraform apply -auto-approve
```

3. Verify results in azure portal OR

```sh
terraform show
```

