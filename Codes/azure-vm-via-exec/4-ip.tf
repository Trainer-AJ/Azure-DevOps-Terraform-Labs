resource "azurerm_public_ip" "this" {
  name                = "vm-ip"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Dynamic"
}
