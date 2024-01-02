resource "azurerm_resource_group" "this" {
  name     = var.rg_name
  location = var.rg_location
  tags = {
    "environment" = "${var.env}",
    "owner" = "Ananay"
  }
}