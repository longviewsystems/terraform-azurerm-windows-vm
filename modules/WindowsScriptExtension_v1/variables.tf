variable "sa_name" {
  type        = string
  description = "Name of the storage account in which the scripts are stored"
}

variable "storage_account_rg" {
  type        = string
  description = "Storage account resource group"
}

variable "enable_for_ansible_configuration" {
  type        = bool
  description = "Set to true to enable winrm in the worker machines."
  default     = false
}

variable "virtual_machine_id" {
  type        = string
  description = "The Virtual Machine ID of the VM to add the extension to."
}