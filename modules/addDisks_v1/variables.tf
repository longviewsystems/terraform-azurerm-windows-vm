variable "disk_name" {
  type = string
  #default     = ""
  description = "The name of the disk to attach."
}


variable "disk_size_gb" {
  type        = number
  description = "Size of the disk."
  default     = 100
}

variable "managed_disk_type" {
  type        = string
  description = "(Required) The type of storage to use for the managed disk. Possible values are Standard_LRS, Premium_LRS, StandardSSD_LRS or UltraSSD_LRS."
  default     = "StandardSSD_LRS"
}

variable "lunID" {
  type = number
  #default     = 10 - No default because duplicates cause errors.
  description = "(Required) The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created."
}

variable "caching" {
  type        = string
  default     = "None"
  description = "(Required) Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
}

variable "location" {
  type        = string
  default     = ""
  description = "(Required) Specified the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}


variable "resource_group_name" {
  type        = string
  default     = ""
  description = "(Required) The name of the Resource Group where the Managed Disk should exist."
}

variable "virtual_machine_id" {
  type = string
  #default     = ""
  description = "(Required) The ID of the Virtual Machine to which the Data Disk should be attached. Changing this forces a new resource to be created."
}

variable "disk_encryption_set_id" {
  type        = string
  default     = ""
  description = "The ID of the Disk Encryption Set used to encrypt this Managed Disk.  If the valu is an empty string, the disks will not be encryted."
}
