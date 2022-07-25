locals {
  #If the password is blank, then use the random pssword.
  passwordToUse = var.admin_password != "" ? var.admin_password : random_password.password.result

  #Use count to determine if PW should be stored in KV or not.  
  UseKV = var.store_admin_password_in_KV != false ? 1 : 0

}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_key_vault_secret" "password" {
  count           = local.UseKV
  name            = azurerm_windows_virtual_machine.main.name
  value           = local.passwordToUse #random_password.password.result
  key_vault_id    = var.admin_password_kv_id
  content_type    = "text/plain"
}