resource "azurerm_subnet" "private-subnet" {
  depends_on = [ azurerm_virtual_network.this ]
  count = length(var.private_subnet_range)
  name                 = "${var.env}-private-subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  # if you don't add [] here it says ERROR: list of string required 
  address_prefixes     = [var.private_subnet_range[count.index]]
}


resource "azurerm_subnet" "public-subnet" {
  depends_on = [ azurerm_virtual_network.this ]
  count = length(var.public_subnet_range)
  name                 = "${var.env}-public-subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.public_subnet_range[count.index]]
}