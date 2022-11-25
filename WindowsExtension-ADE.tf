data "azurerm_key_vault" "disks" {
  count               = var.Encrpyt_all_VM_Disks ? 1 : 0
  name                = var.Disk_Encryt_key_vault_name
  resource_group_name = var.Disk_Encryt_key_vault_resource_group
}

resource "azurerm_key_vault_key" "disks" {
  count        = var.Encrpyt_all_VM_Disks ? 1 : 0
  name         = "${var.vm_name}-DK"
  key_vault_id = data.azurerm_key_vault.disks[0].id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "azurerm_virtual_machine_extension" "ADE" {
  count                      = var.Encrpyt_all_VM_Disks ? 1 : 0
  name                       = "${var.vm_name}-ADE-Extension"
  virtual_machine_id         = azurerm_windows_virtual_machine.main.id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "AzureDiskEncryption"
  type_handler_version       = "2.2"
  auto_upgrade_minor_version = true
  #tags                          = "${var.vm_encry_tags}"

  settings = <<SETTINGS
                {
                    "EncryptionOperation":      "EnableEncryption",
                    "KeyVaultURL": "${data.azurerm_key_vault.disks[0].vault_uri}",
                    "KeyVaultResourceId": "${data.azurerm_key_vault.disks[0].id}",					
                    "KeyEncryptionKeyURL": "${azurerm_key_vault_key.disks[0].id}",
                    "KekVaultResourceId": "${data.azurerm_key_vault.disks[0].id}",					
                    "KeyEncryptionAlgorithm": "RSA-OAEP",
                    "VolumeType": "All"
                }
             SETTINGS


  depends_on = [
    module.InitializeDisks
  ]

  tags = var.tags

}