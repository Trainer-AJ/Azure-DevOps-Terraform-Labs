# In powershell : ssh-keygen -t rsa -b 2048
resource "azurerm_resource_group" "this" {
  name     = "vm-terraform"
  location = "Central India"
}