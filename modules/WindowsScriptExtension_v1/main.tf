#Docs:
#https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension


#Example: http://hypernephelist.com/2019/06/25/azure-vm-custom-script-extensions-with-terraform.html

/*
NOTES
- TF Function: templatefile Reads a file, and replaces text with other text.
*/

locals {
  scriptName     = var.scriptName                                      #This cannot be the full path.  Must be script name only.
  scriptRendered = filebase64("${var.scriptPath}/${local.scriptName}") #Full path.
  # use templatefile() to parse script parameters
  #ifTemplateFile = base64encode(templatefile("${path.module}/${local.scriptName}", {}))
  commandToExecute = jsonencode({
    commandToExecute = "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${local.scriptRendered}')) | Out-File -filepath ${local.scriptName}\" && powershell -ExecutionPolicy Unrestricted -File ${local.scriptName}"
  })
}

# settings block will look like

resource "azurerm_virtual_machine_extension" "ScriptExtension" {
  name                 = "ScriptExtension"
  virtual_machine_id   = var.virtual_machine_id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  protected_settings = local.commandToExecute

}