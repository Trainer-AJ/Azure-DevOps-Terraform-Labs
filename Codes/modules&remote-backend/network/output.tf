output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "private_subnet_id" {
  depends_on = [ azurerm_virtual_network.this ]
  value = azurerm_subnet.private-subnet[*].id
}

output "public_subnet_id" {
  value = azurerm_subnet.public-subnet[*].id
}

output "rg-name" {
    value = azurerm_resource_group.this.name
}

output "rg-location" {
  value = azurerm_resource_group.this.location
}

output "nic-id" {
    value = azurerm_network_interface.this.id
}