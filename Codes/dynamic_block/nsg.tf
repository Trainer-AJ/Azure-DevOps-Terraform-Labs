resource "azurerm_resource_group" "this" {
  name     = "nsg-resources"
  location = "Central India"
}

resource "azurerm_network_security_group" "subnet_nsg" {
  name                = "dynamic-nsg-rules"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

 dynamic security_rule {
    for_each = var.subnet_nsg_rules
    content {
    #    FORMULA = resource_type.value["name_of_variable_value"]
    name                       = security_rule.value["name"]
    priority                   = security_rule.value["priority"]
    direction                  = security_rule.value["direction"]
    access                     = security_rule.value["access"]
    protocol                   = security_rule.value["protocol"]
    source_port_range          = security_rule.value["source_port_range"]
    destination_port_range     = security_rule.value["destination_port_range"]
    source_address_prefix      = security_rule.value["source_address_prefix"]
    destination_address_prefix = security_rule.value["destination_address_prefix"]
  }
 }

  tags = {
    environment = "Production"
  }
}