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

variable "init_script_url" {
  type        = string
  description = "URL of the Initialzie powershell script from the storage account"
}

variable "winrm_script_url" {
  type        = string
  description = "URL of the WinRM powershell script from the storage account"
}
