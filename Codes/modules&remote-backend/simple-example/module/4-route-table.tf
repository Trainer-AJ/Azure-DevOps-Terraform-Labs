resource "azurerm_route_table" "private-route-table" {
  name                          = "this-route-table"
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name
  disable_bgp_route_propagation = false

  route {
    name           = "intra-vnet"
    address_prefix = var.vnet_address[0]
    next_hop_type  = "VnetLocal"
  }

  tags = merge({Name = "${var.env}-route-table"},var.private-subnet-tags)
    
}

resource "azurerm_route" "private-routes" {
  name                = "no-to-internet"
  resource_group_name = azurerm_resource_group.this.name
  route_table_name    = azurerm_route_table.private-route-table.name
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "None"
}

resource "azurerm_subnet_route_table_association" "add-2-private" {
  count = length(var.private_subnet_range)
  subnet_id      = azurerm_subnet.private-subnet[count.index].id
  route_table_id = azurerm_route_table.private-route-table.id
}