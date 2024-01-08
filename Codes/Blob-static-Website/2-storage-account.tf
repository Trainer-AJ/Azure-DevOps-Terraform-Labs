# 21-nov-23: Terraform by default allows anayonous blob access
resource "azurerm_storage_account" "this" {
  name                = var.storage_name
  resource_group_name = azurerm_resource_group.this.name

  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind = "StorageV2"
  static_website {
    index_document = "index.html"
    error_404_document = "error.html"
  }

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
  name                   = "home.html"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type = "text/html"
  source                 = var.index_html
}

resource "azurerm_storage_blob" "error" {
  name                   = "error.html"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type = "text/html"
  source                 = var.error
}

resource "azurerm_storage_blob" "mtm" {
  name                   = "MTM"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type = "text/html"
  source                 = "C:/Users/anana/OneDrive/Documents/MTM Reports/27-Apr-23-HCL-Class_Summary.pdf"
}

variable "content_types" {
  type    = map(string)
  default = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "text/javascript"
  }
}

resource "azurerm_storage_blob" "example" {
  for_each            = fileset(var.folder, "**/*")
  name                = each.value
  storage_account_name = azurerm_storage_account.this.name
  storage_container_name = "$web"
  type                = "Block"
  source              = "${var.folder}/${each.value}"

  # Set content type based on file extension
  content_type = lookup(var.content_types, pathext(each.value), "application/octet-stream")

}