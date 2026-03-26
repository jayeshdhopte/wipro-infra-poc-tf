locals {
  rg_name = var.resource_group

  rg_location = (
    length(data.azurerm_resource_group.rg) > 0
    ? data.azurerm_resource_group.rg[0].location
    : var.resource_group_region
  )

  vnet_name = (
    length(data.azurerm_virtual_network.vnet) > 0
    ? data.azurerm_virtual_network.vnet[0].name
    : var.virtual_network_name
  )

  subnet_id = (
    length(data.azurerm_subnet.subnet) > 0
    ? data.azurerm_subnet.subnet[0].id
    : azurerm_subnet.subnet[0].id
  )

  nic_id = (
    length(data.azurerm_network_interface.nic) > 0
    ? data.azurerm_network_interface.nic[0].id
    : azurerm_network_interface.nic[0].id
  )
}