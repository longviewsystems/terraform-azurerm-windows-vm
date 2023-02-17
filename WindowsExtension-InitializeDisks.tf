module "InitializeDisks" {
  count                            = var.enable_InitializeDisks_extension ? 1 : 0
  source                           = "./modules/WindowsScriptExtension_v1"
  virtual_machine_id               = azurerm_windows_virtual_machine.main.id
  enable_for_ansible_configuration = var.enable_for_ansible_configuration
  sa_name                          = var.sa_name
  storage_account_rg               = var.storage_account_rg

  depends_on = [
    module.AddDisks
  ]

  //tags = var.tags

}


