locals {
  imageParts      = split(":", var.image_URN)
  image_publisher = local.imageParts[0]
  image_offer     = local.imageParts[1]
  image_sku       = local.imageParts[2]
  image_version   = local.imageParts[3]
}


# Create network interface
resource "azurerm_network_interface" "nic" {

  name                = "${var.vm_name}${var.vm_nic_naming_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "${var.vm_name}${var.vm_nic_config_naming_suffix}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {}
}

# Create virtual machine
resource "azurerm_windows_virtual_machine" "main" {
  name                     = var.vm_name
  size                     = var.vm_size
  location                 = var.location
  resource_group_name      = var.resource_group_name
  network_interface_ids    = [azurerm_network_interface.nic.id]
  computer_name            = var.vm_name
  admin_username           = var.admin_username
  admin_password           = local.passwordToUse
  provision_vm_agent       = true
  enable_automatic_updates = true

  # timezone                 = "Eastern Standard Time"

  #Add to AV Set if availability_set_id is blank.
  availability_set_id = var.availability_set_id != "" ? var.availability_set_id : null

  identity {
    type = "SystemAssigned"
  }

  /* For testing
  plan {
    publisher = var.publisher
    product   = var.offer
    name      = var.sku
  }
  */


  #dynamic blocks only support for_each, not count.
  dynamic "plan" {
    for_each = var.use_dynamic_plan ? [0] : []
    content {
      publisher = local.image_publisher
      product   = local.image_offer
      name      = local.image_sku
    }
  }

  source_image_reference {
    publisher = local.image_publisher
    offer     = local.image_offer
    sku       = local.image_sku
    version   = local.image_version
  }

  os_disk {
    name                 = "${var.vm_name}${var.os_disk_suffix}"
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_managed_disk_type
    disk_size_gb         = var.os_disk_disk_size_gb
  }

  tags = var.tags

}

################################################################
#EOF