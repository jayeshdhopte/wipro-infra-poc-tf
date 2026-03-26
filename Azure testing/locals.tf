locals {
  rg_name     = try(data.azurerm_resource_group.rg[0].name, azurerm_resource_group.rg[0].name)
  rg_location = try(data.azurerm_resource_group.rg[0].location, azurerm_resource_group.rg[0].location)

  vnet_name = try(data.azurerm_virtual_network.vnet[0].name, azurerm_virtual_network.vnet[0].name)

  subnet_id = try(data.azurerm_subnet.subnet[0].id, azurerm_subnet.subnet[0].id)

  nic_id = try(data.azurerm_network_interface.nic[0].id, azurerm_network_interface.nic[0].id)
}