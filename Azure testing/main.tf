data "azurerm_resource_group" "rg" {
  count = var.rg_choice == "Exists" ? 1 : 0
  name  = var.resource_group
}

resource "azurerm_resource_group" "rg" {
  count    = var.rg_choice == "Do Not Exist" ? 1 : 0
  name     = var.resource_group
  location = var.resource_group_region
}

data "azurerm_virtual_network" "vnet" {
  count               = var.vnet_choice == "Exists" ? 1 : 0
  name                = var.virtual_network_name
  resource_group_name = local.rg_name
}

resource "azurerm_virtual_network" "vnet" {
  count               = var.vnet_choice == "Do Not Exist" ? 1 : 0
  name                = var.virtual_network_name
  location            = local.rg_location
  resource_group_name = local.rg_name
  address_space       = var.vnet_address_prefix
}



data "azurerm_subnet" "subnet" {
  count                = var.subnet_choice == "Exists" ? 1 : 0
  name                 = var.subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.rg_name
}

resource "azurerm_subnet" "subnet" {
  count                = var.subnet_choice == "Do Not Exist" ? 1 : 0
  name                 = var.subnet_name
  resource_group_name  = local.rg_name
  virtual_network_name = local.vnet_name
  address_prefixes     = var.subnet_address_prefix
}


data "azurerm_network_security_group" "nsg" {
  count               = var.nsg_choice == "Exists" ? 1 : 0
  name                = var.nsg_name
  resource_group_name = local.rg_name
}

resource "azurerm_network_security_group" "nsg" {
  count               = var.nsg_choice == "Do Not Exist" ? 1 : 0
  name                = var.nsg_name
  location            = local.rg_location
  resource_group_name = local.rg_name
}

resource "azurerm_network_security_rule" "rule" {
  count                       = var.nsg_choice == "Do Not Exist" ? 1 : 0
  name                        = var.rule_name
  priority                    = var.rule_priority
  direction                   = var.rule_direction
  access                      = var.rule_access
  protocol                    = var.rule_protocol
  source_port_range           = var.source_port_range
  destination_port_range      = var.destination_port_range
  source_address_prefix       = var.nsg_source_address_prefix
  destination_address_prefix  = var.nsg_destination_address_prefix
  resource_group_name         = local.rg_name
  network_security_group_name = azurerm_network_security_group.nsg[0].name
}



resource "azurerm_public_ip" "pip" {
  name                = var.public_ip_name
  location            = local.rg_location
  resource_group_name = local.rg_name
  allocation_method   = var.pip_allocation_method
}

data "azurerm_network_interface" "nic" {
  count               = var.nic_choice == "Exists" ? 1 : 0
  name                = var.nic_name
  resource_group_name = local.rg_name
}

resource "azurerm_network_interface" "nic" {
  count               = var.nic_choice == "Do Not Exist" ? 1 : 0
  name                = var.nic_name
  location            = local.rg_location
  resource_group_name = local.rg_name

  ip_configuration {
    name                          = var.ip_config_name
    subnet_id                     = local.subnet_id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}
data "azurerm_shared_image_version" "image" {
  count               = var.use_shared_image ? 1 : 0
  name                = var.shared_image_version
  image_name          = var.image_definition_name
  gallery_name        = var.shared_gallery
  resource_group_name = local.rg_name
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.os_disk_choice == "Do Not Exist" ? 1 : 0
  name                = var.virtual_machine_name
  location            = local.rg_location
  resource_group_name = local.rg_name
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [local.nic_id]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("${path.module}/ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = var.operating_system_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = "latest"
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_storage_account_type
  }
}

