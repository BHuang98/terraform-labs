output "hub_vnet_id" {
    value = azurerm_virtual_network.hub.id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}