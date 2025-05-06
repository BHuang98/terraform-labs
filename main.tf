provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "secure-hub-spoke-rg"
  location = "westus2"
}

resource "azurerm_virtual_network" "hub" {
  name = "Hub-vnet"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_security_center_subscription_pricing" "defender" {
  tier = "Free"
  resource_type = "VirtualMachines"
}

resource "azurerm_network_security_group" "nsg" {
  name = "NSGtest"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  } 
}

resource "azurerm_security_center_subscription_pricing" "defender_storage" {
  tier          = "Free"
  resource_type = "StorageAccounts"
}