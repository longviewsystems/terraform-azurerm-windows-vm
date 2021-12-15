variable "scriptName" {
  type        = string
  description = "The name of the script to be run. Path and name must be seperate."
}

variable "scriptPath" {
  type        = string
  description = "The path of the script to be run.  Path and name must be seperate."
}

variable "virtual_machine_id" {
  type        = string
  description = "The Virtual Machine ID of the VM to add the extension to."
}
