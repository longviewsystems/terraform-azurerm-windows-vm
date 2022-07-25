# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------
output "rg_name" {
  value       = data.azurerm_resource_group.resourcegroup.name
  description = "Resource Group Name"
}

output "rg_id" {
  value       = data.azurerm_resource_group.resourcegroup.id
  description = "Resource Group ID"
}

output "vnet_name" {
  value       = data.azurerm_virtual_network.net.name
  description = "vNet Name"
}

output "vnet_id" {
  value       = data.azurerm_virtual_network.net.id
  description = "vNet ID"
}

output "subnet_name" {
  value       = data.azurerm_subnet.net.name
  description = "Subnet name"
}

output "subnet_id" {
  value       = data.azurerm_subnet.net.id
  description = "Subnet ID"
}

output "virtual_machine_name" {
  value       = azurerm_windows_virtual_machine.main.name
  description = "Windows VM name"
}

output "virtual_machine_id" {
  value       = azurerm_windows_virtual_machine.main.id
  description = "Windows VM ID"
}

