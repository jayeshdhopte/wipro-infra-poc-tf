locals {
  rg_name = var.resource_group

  rg_location = var.rg_choice == "Exists" ? data.azurerm_resource_group.rg[0].location : var.resource_group_region

  vnet_name = var.vnet_choice == "Exist" ? data.azurerm_virtual_network.vnet[0].name : var.virtual_network_name

  subnet_id = var.subnet_choice == "Exists" ? data.azurerm_subnet.subnet[0].id : azurerm_subnet.subnet[0].id

  nic_id = var.nic_choice == "Exists" ? data.azurerm_network_interface.nic[0].id : azurerm_network_interface.nic[0].id
}