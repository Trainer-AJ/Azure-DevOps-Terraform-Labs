resource "azurerm_virtual_network" "this" {
  name                = "this-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  depends_on = [ azurerm_resource_group.this ]
}

resource "azurerm_subnet" "this" {
  name                 = "subnet-1"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on = [ azurerm_virtual_network.this ]
}
