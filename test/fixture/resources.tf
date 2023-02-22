/*****************************************
/*   Naming conventions
/*****************************************/

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.1.1"
  prefix  = ["mod", "test"]
  # suffix = random_string.random.value

  unique-include-numbers = false
  unique-length          = 4
}

/*****************************************
/*   Resource Group
/*****************************************/

resource "azurerm_resource_group" "fixture" {
  name     = module.naming.resource_group.name_unique
  location = var.location
  tags     = var.tags
}

/*****************************************
/*   vNet
/*****************************************/

resource "azurerm_virtual_network" "fixture" {
  name                = module.naming.virtual_network.name_unique
  address_space       = ["10.30.0.0/16"]
  location            = azurerm_resource_group.fixture.location
  resource_group_name = azurerm_resource_group.fixture.name
  tags                = var.tags
}

resource "azurerm_subnet" "fixture_sn1" {
  name                 = "sn1"
  resource_group_name  = azurerm_resource_group.fixture.name
  virtual_network_name = azurerm_virtual_network.fixture.name
  address_prefixes     = ["10.30.1.0/24"]

}

/*****************************************
/*   Availibity Set
/*****************************************/
resource "azurerm_availability_set" "fixture" {
  name                         = module.naming.availability_set.name_unique
  location                     = azurerm_resource_group.fixture.location
  resource_group_name          = azurerm_resource_group.fixture.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  tags                         = var.tags
}



/*****************************************
/*   Storage Account
/*****************************************/
resource "azurerm_storage_account" "fixture" {
  name                = module.naming.storage_account.name_unique
  location            = azurerm_resource_group.fixture.location
  resource_group_name = azurerm_resource_group.fixture.name
  #virtual_network_name = azurerm_virtual_network.fixture.name
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = var.tags
}

/*****************************************
/*   Key Vault
/*****************************************/

//data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "fixture" {
  name                        = module.naming.key_vault.name_unique
  location                    = azurerm_resource_group.fixture.location
  resource_group_name         = azurerm_resource_group.fixture.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  #public_network_access_enabled = true

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
    ]

    secret_permissions = [
      "Get", "Set", "List", "Purge", "Recover", "Restore", "Delete"
    ]

    storage_permissions = [
      "Get",
    ]
  }

   network_acls {
     bypass         = "AzureServices"
     default_action = "Allow"
    //virtual_network_subnet_ids = [azurerm_subnet.fixture_sn1.id]
   }
}