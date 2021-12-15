output "azurerm_managed_disk_id" {
  value = azurerm_managed_disk.disk.id
}

output "azurerm_virtual_machine_data_disk_attachment_id" {
  value = azurerm_virtual_machine_data_disk_attachment.disk.id
}