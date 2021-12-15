resource "azurerm_managed_disk" "disk" {
  name                   = var.disk_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  storage_account_type   = var.managed_disk_type
  create_option          = "Empty"
  disk_size_gb           = var.disk_size_gb
  disk_encryption_set_id = var.disk_encryption_set_id != "" ? var.disk_encryption_set_id : null

  #Encrypting the disk happens through ADE.
  lifecycle {
    ignore_changes = [
      encryption_settings
    ]
  }

}

resource "azurerm_virtual_machine_data_disk_attachment" "disk" {
  managed_disk_id    = azurerm_managed_disk.disk.id
  virtual_machine_id = var.virtual_machine_id
  lun                = var.lunID
  caching            = var.caching

  /*
    lifecycle {
      ignore_changes = [
        managed_disk_id, id

      ]
    }
    */

}
