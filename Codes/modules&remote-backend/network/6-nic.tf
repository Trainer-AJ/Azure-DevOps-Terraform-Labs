resource "azurerm_network_interface" "this" {
  name                = "vm-nic"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
depends_on = [ azurerm_public_ip.this ]

# module.vnet.azurerm_subnet.public-subnet[0]
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public-subnet[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.this.id
  }
}
