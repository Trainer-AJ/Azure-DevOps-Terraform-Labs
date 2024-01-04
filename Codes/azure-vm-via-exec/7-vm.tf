resource "azurerm_linux_virtual_machine" "this" {
  name                = "terraform-machine"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = "Standard_B1ls"
  admin_username      = "ananay"
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_ssh_key {
    username   = "ananay"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  # user_data = file("${path.module}/install_wordpress.sh")

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
 # user_data = filebase64("./install_wordpress.sh")

 provisioner "file" {
   source = "${path.module}/test.sh"
   destination = "/tmp/test.sh"
   connection {
     type = "ssh"
     host = azurerm_linux_virtual_machine.this.public_ip_address
     user = "ananay"
     private_key = file("~/.ssh/id_rsa")
   }
 }

provisioner "remote-exec" {
  inline = [ 
    "chmod +x /tmp/test.sh",
    "/tmp/test.sh"
   ]
  connection {
     type = "ssh"
     host = azurerm_linux_virtual_machine.this.public_ip_address
     user = "ananay"
     private_key = file("~/.ssh/id_rsa")
   }
}
  provisioner "local-exec" {
    on_failure = continue
    command = "Write-Host ************************ My name is Mangu ! ************************"
    interpreter = [ "Powershell", "-Command" ]
  }
}