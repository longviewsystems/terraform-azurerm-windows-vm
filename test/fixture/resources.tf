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
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.fixture.location
  resource_group_name = azurerm_resource_group.fixture.name
  tags                = var.tags
}

resource "azurerm_subnet" "fixture_sn1" {
  name                 = "sn1"
  resource_group_name  = azurerm_resource_group.fixture.name
  virtual_network_name = azurerm_virtual_network.fixture.name
  address_prefixes     = ["10.0.1.0/24"]

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