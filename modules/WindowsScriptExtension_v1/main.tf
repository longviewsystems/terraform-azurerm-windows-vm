#Docs:
#https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension


#Example: http://hypernephelist.com/2019/06/25/azure-vm-custom-script-extensions-with-terraform.html

/*
NOTES
- TF Function: templatefile Reads a file, and replaces text with other text.
*/

# settings block will look like

data "azurerm_storage_account" "test" {
  name                = var.sa_name
  resource_group_name = var.storage_account_rg
}

resource "azurerm_virtual_machine_extension" "ScriptExtension" {
  name                       = "ScriptExtension"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true
  protected_settings         = <<PROTECTED_SETTINGS
    {         
            "fileUris": ["https://ansibleteststrgaccnt.blob.core.windows.net/winrmext/InitializeDisks.ps1",
                         "https://ansibleteststrgaccnt.blob.core.windows.net/winrmext/ConfigureRemotingForAnsible.ps1"],
            "storageAccountName": "${var.sa_name}",
            "storageAccountKey": "${data.azurerm_storage_account.test.primary_access_key}",
            "commandToExecute": "powershell.exe -ExecutionPolicy ByPass -File InitializeDisks.ps1 -winrmenablement ${var.enable_for_ansible_configuration}"
    }
  PROTECTED_SETTINGS

}