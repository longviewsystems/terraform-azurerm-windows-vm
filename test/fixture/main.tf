data "azurerm_client_config" "current" {}

/*

Setup the module for testing.

*/

module "vm_test_1" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.fixture.name
  location            = var.location


  admin_password             = "" #blank means randomize it in the module.
  subnet_id                  = azurerm_subnet.fixture_sn1.id
  backup_vault_enabled       = false
  use_dynamic_plan           = false
  vm_name                    = "vm-win-test1"
  availability_set_id        = null
  image_URN                  = "MicrosoftWindowsServer:WindowsServer:2019-Datacenter-smalldisk:latest"
  Encrpyt_all_VM_Disks       = false
  vm_size                    = "Standard_D2s_v5"
  store_admin_password_in_KV = false
  data_disk_details = {
    12 = {
      disk_size_gb      = 100,
      managed_disk_type = "StandardSSD_LRS",
      lunID             = 12
    },
    13 = {
      disk_size_gb      = 100,
      managed_disk_type = "StandardSSD_LRS",
      lunID             = 13
    },
  }

  tags           = var.tags
  admin_username = "adminusername"
}

module "vm_test_2" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.fixture.name
  location            = var.location


  admin_password             = "" #blank means randomize it in the module.
  subnet_id                  = azurerm_subnet.fixture_sn1.id
  backup_vault_enabled       = false
  use_dynamic_plan           = false
  vm_name                    = "vm-win-test2a"
  availability_set_id        = azurerm_availability_set.fixture.id
  image_URN                  = "MicrosoftWindowsServer:WindowsServer:2019-Datacenter:latest"
  Encrpyt_all_VM_Disks       = false
  vm_size                    = "Standard_D2s_v5"
  store_admin_password_in_KV = true
  admin_password_kv_id       = azurerm_key_vault.fixture.id
  data_disk_details          = {}
  tags                       = var.tags
  admin_username             = "adminusername"
}


module "vm_test_2b" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.fixture.name
  location            = var.location

  admin_password             = "" #blank means randomize it in the module.
  subnet_id                  = azurerm_subnet.fixture_sn1.id
  backup_vault_enabled       = false
  use_dynamic_plan           = false
  vm_name                    = "vm-win-test2b"
  availability_set_id        = azurerm_availability_set.fixture.id
  image_URN                  = "MicrosoftWindowsServer:WindowsServer:2019-Datacenter:latest"
  Encrpyt_all_VM_Disks       = false
  vm_size                    = "Standard_D2s_v5"
  store_admin_password_in_KV = true
  admin_password_kv_id       = azurerm_key_vault.fixture.id
  data_disk_details          = {}
  tags                       = var.tags
  admin_username             = "adminusername"
}