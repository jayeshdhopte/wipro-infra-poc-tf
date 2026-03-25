locals {
  rg_name     = var.rg_choice == "Exists" ? data.azurerm_resource_group.rg[0].name : azurerm_resource_group.rg[0].name
  rg_location = var.rg_choice == "Exists" ? data.azurerm_resource_group.rg[0].location : azurerm_resource_group.rg[0].location

  vnet_name = var.vnet_choice == "Exists" ? data.azurerm_virtual_network.vnet[0].name : azurerm_virtual_network.vnet[0].name

  subnet_id = var.subnet_choice == "Exists" ? data.azurerm_subnet.subnet[0].id : azurerm_subnet.subnet[0].id

  nsg_id = var.nsg_choice == "Exists" ? data.azurerm_network_security_group.nsg[0].id : azurerm_network_security_group.nsg[0].id

  nic_id = var.nic_choice == "Exists" ? data.azurerm_network_interface.nic[0].id : azurerm_network_interface.nic[0].id
}