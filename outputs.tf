# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------
output "virtual_machine_name" {
  value       = azurerm_windows_virtual_machine.main.name
  description = "Windows VM name"
}

output "virtual_machine_id" {
  value       = azurerm_windows_virtual_machine.main.id
  description = "Windows VM ID"
}

