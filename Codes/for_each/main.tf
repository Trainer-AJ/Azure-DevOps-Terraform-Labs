# erraform apply -auto-approve -var-file="rg.tfvars"

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

resource "azurerm_resource_group" "example" {
  for_each = var.rg_map
  name     = "${each.key}-RG"
  location = each.value
}

resource "azurerm_public_ip" "example" {
  # -----------------------------------------------------
  # Hover on the Azurerm_RG to know the available attributes of RG
  for_each = azurerm_resource_group.example

  # Here we fetch values from variable 
  name = "ip-${each.value.location}"

  # Here we Fetch values from Resource Group Created Before
  resource_group_name = azurerm_resource_group.example[each.key].name

  # location            = each.value.location OR
  location          = azurerm_resource_group.example[each.key].location
  allocation_method = "Static"
  tags              = var.tags
}
# https://developer.hashicorp.com/terraform/language/meta-arguments/for_each

output "ip" {
  value = {
    for name, ip in azurerm_public_ip.example :name => ip.ip_address
  }
  depends_on = [azurerm_public_ip.example]
}


# ---------------------------------- NOTE ---------------------------------------
/*
The TF resource, azurerm_resource_group.example have 
{
  id = string
  location = string
  managed_by = string
  name = string
  tags = map of string
}

so, azurerm_resource_group.example[each.key].name means from keys
i.e [id,location,managed_by,tags]
get each value of name field

for each output formula:
for var1, var2 in terraform_resource : var1  => var2.attribute1 of tf resource

if var1 or var2 have attributes you can also access them like:
var1 => var2.ip_address or any attribute

*/