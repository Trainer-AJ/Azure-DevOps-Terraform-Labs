resource "azurerm_linux_virtual_machine" "vm1" {
  name                = var.vm-name
  resource_group_name = module.vnet.rg-name
  location            = module.vnet.rg-location
    size                = var.vm-size
  admin_username      = var.vm-user
  network_interface_ids = [
    module.vnet.nic-id,
  ]

  admin_ssh_key {
    username   = var.vm-user
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

connection {
     type = "ssh"
     host = azurerm_linux_virtual_machine.vm1.public_ip_address
     user = var.vm-user
     private_key = file("~/.ssh/id_rsa")
   }

provisioner "remote-exec" {
   on_failure = continue
  scripts = [ "scripts/test.sh" ]
  
}
  provisioner "local-exec" {
    on_failure = continue
    command = "Write-Host ************************ Devops with terraform ! ************************"
    interpreter = [ "Powershell", "-Command" ]
  }
}