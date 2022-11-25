module "InitializeDisks" {
  count              = var.enable_InitializeDisks_extension ? 1 : 0
  source             = "./modules/WindowsScriptExtension_v1"
  scriptName         = "InitializeDisks.ps1"                              #The name of the script to be run. Path and name must be seperate."
  scriptPath         = "${path.module}/modules/WindowsScriptExtension_v1" #"The path of the script to be run.  Path and name must be seperate."
  virtual_machine_id = azurerm_windows_virtual_machine.main.id

  depends_on = [
    module.AddDisks
  ]

  tags = var.tags

}


