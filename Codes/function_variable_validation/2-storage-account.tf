# 21-nov-23: Terraform by default allows anayonous blob access
resource "azurerm_storage_account" "this" {
  name                = var.str_name
  resource_group_name = azurerm_resource_group.this.name

  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind = "StorageV2"
  tags = {
    environment = "staging"
  }
}

#Create container and upload blob
# GOt error auto created as it auto creates $web
# withput ${var.folder} gives error can't find location
# without content_type doesn't shows up in browser, downloads insted
# as when uploaded via terraform gives content type = application/octet-stream
resource "azurerm_storage_blob" "main" {
  name                   = "image"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = "image"
  type                   = "Block"
  content_type = "image/png"
  source                 = fileexists(var.file) ? var.file : "Subscribe-Cloud-Portfolio-3.png"
}

# condition ? true_val : false_val
