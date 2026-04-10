# ==========================================
# 1. RESOURCE GROUP
# ==========================================
data "azurerm_resource_group" "rg" {
  count = lower(var.rg_choice) == "exists" ? 1 : 0
  name  = var.resource_group
}

resource "azurerm_resource_group" "rg" {
  count    = lower(var.rg_choice) != "exists" ? 1 : 0
  name     = var.resource_group
  location = var.resource_group_region
}

locals {
  rg_name     = lower(var.rg_choice) == "exists" ? data.azurerm_resource_group.rg[0].name : azurerm_resource_group.rg[0].name
  rg_location = lower(var.rg_choice) == "exists" ? data.azurerm_resource_group.rg[0].location : azurerm_resource_group.rg[0].location
}

# ==========================================
# 2. VIRTUAL NETWORK
# ==========================================
data "azurerm_virtual_network" "vnet" {
  count               = lower(var.vnet_choice) == "exists" ? 1 : 0
  name                = var.virtual_network_name
  resource_group_name = local.rg_name
}

resource "azurerm_virtual_network" "vnet" {
  count               = lower(var.vnet_choice) != "exists" ? 1 : 0
  name                = var.virtual_network_name
  location            = local.rg_location
  resource_group_name = local.rg_name
  address_space       = [var.vnet_address_prefix] # Formats the string into a list
}

locals {
  vnet_name = lower(var.vnet_choice) == "exists" ? data.azurerm_virtual_network.vnet[0].name : azurerm_virtual_network.vnet[0].name
}

# ==========================================
# 3. SUBNET
# ==========================================
data "azurerm_subnet" "subnet" {
  count                = lower(var.subnet_choice) == "exists" ? 1 : 0
  name                 = var.subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.rg_name
}

resource "azurerm_subnet" "subnet" {
  count                = lower(var.subnet_choice) != "exists" ? 1 : 0
  name                 = var.subnet_name
  resource_group_name  = local.rg_name
  virtual_network_name = local.vnet_name
  address_prefixes     = [var.subnet_address_prefix] # Formats the string into a list
}

locals {
  subnet_id = lower(var.subnet_choice) == "exists" ? data.azurerm_subnet.subnet[0].id : azurerm_subnet.subnet[0].id
}

# ==========================================
# 4. NETWORK SECURITY GROUP & RULES
# ==========================================
data "azurerm_network_security_group" "nsg" {
  count               = lower(var.nsg_choice) == "exists" ? 1 : 0
  name                = var.nsg_name
  resource_group_name = local.rg_name
}

resource "azurerm_network_security_group" "nsg" {
  count               = lower(var.nsg_choice) != "exists" ? 1 : 0
  name                = var.nsg_name
  location            = local.rg_location
  resource_group_name = local.rg_name
}

locals {
  nsg_id   = lower(var.nsg_choice) == "exists" ? data.azurerm_network_security_group.nsg[0].id : azurerm_network_security_group.nsg[0].id
  nsg_name = lower(var.nsg_choice) == "exists" ? data.azurerm_network_security_group.nsg[0].name : azurerm_network_security_group.nsg[0].name
}

resource "azurerm_network_security_rule" "rule" {
  count                       = lower(var.nsg_choice) != "exists" ? 1 : 0
  name                        = var.rule_name
  priority                    = var.rule_priority
  direction                   = title(lower(var.rule_direction))
  access                      = title(lower(var.rule_access))
  protocol                    = title(lower(var.rule_protocol))
  
  source_port_range           = var.source_port_range
  destination_port_range      = var.destination_port_range
  source_address_prefix       = var.nsg_source_address_prefix
  destination_address_prefix  = var.nsg_destination_address_prefix
  resource_group_name         = local.rg_name
  network_security_group_name = local.nsg_name
}

# ==========================================
# 4.5 CUSTOM IMAGE DATA
# ==========================================
data "azurerm_shared_image_version" "custom" {
  name                = var.shared_image_version     # e.g., "0.0.1"
  image_name          = var.image_definition_name    # e.g., "goldenimge"
  gallery_name        = var.shared_gallery           # e.g., "RHEL"
  resource_group_name = local.rg_name      # Replace with the RG where the Gallery lives
}

# ==========================================
# 5. PUBLIC IP & NETWORK INTERFACE
# ==========================================
resource "azurerm_public_ip" "pip" {
  count               = var.public_ip_required == "true" ? 1 : 0
  name                = var.public_ip_name != "" ? var.public_ip_name : "${var.virtual_machine_name}-pip"
  location            = local.rg_location
  resource_group_name = local.rg_name
  sku                 = "Standard"
  allocation_method    = "Static"
}

data "azurerm_network_interface" "nic" {
  count               = lower(var.nic_choice) == "exists" ? 1 : 0
  name                = var.nic_name
  resource_group_name = local.rg_name
}

resource "azurerm_network_interface" "nic" {
  count               = lower(var.nic_choice) != "exists" ? 1 : 0
  name                = var.nic_name
  location            = local.rg_location
  resource_group_name = local.rg_name

  ip_configuration {
    name                          = var.ip_config_name
    subnet_id                     = local.subnet_id
    private_ip_address_allocation = var.private_ip_allocation

    private_ip_address            = var.private_ip_allocation == "Static" ? "10.0.1.10" : null
    
    # Only attach Public IP if the user selected it in ServiceNow
    public_ip_address_id          = var.public_ip_required == "true" ? azurerm_public_ip.pip[0].id : null
  }
}

locals {
  nic_id = lower(var.nic_choice) == "exists" ? data.azurerm_network_interface.nic[0].id : azurerm_network_interface.nic[0].id
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  count                     = lower(var.nic_choice) != "exists" ? 1 : 0
  network_interface_id      = local.nic_id
  network_security_group_id = local.nsg_id
}

# ==========================================
# 6. VIRTUAL MACHINE
# ==========================================
resource "azurerm_virtual_machine" "vm" {
  name                  = var.virtual_machine_name
  location              = local.rg_location
  resource_group_name   = local.rg_name
  vm_size               = var.vm_size
  network_interface_ids = [local.nic_id]

# FIX: In this resource, you use this block instead of 'source_image_id'
  storage_image_reference {
    id = data.azurerm_shared_image_version.custom.id
  }

  # FIX: In this resource, it is 'storage_os_disk', not 'os_disk'
  storage_os_disk {
    name              = "${var.virtual_machine_name}-osdisk"
    caching           = lower(var.os_disk_caching) == "none" ? "None" : (lower(var.os_disk_caching) == "readonly" ? "ReadOnly" : "ReadWrite")
    create_option     = "FromImage"
    managed_disk_type = var.os_storage_account_type
  }

  # IMPORTANT: We leave out the 'os_profile' block entirely 
  # so that Azure treats this as a SPECIALIZED image.
}
