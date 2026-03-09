terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  # Note: Azure expects regions formatted like "eastus" or "centralindia"
  location = var.resource_group_region
  tags = {
    Environment = var.environment
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = [var.vnet_address_prefix]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.virtual_machine_name}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.virtual_machine_name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  # Standard size for POC, we can map your RAM/vCPU variables to an Azure size later!
  size                            = "Standard_B2s" 
  admin_username                  = "adminuser"
  admin_password                  = "WiproPOC_Temp_P@ssw0rd!" # Hardcoded for quick POC testing
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.os_publisher == "redhat" ? "RedHat" : "Canonical"
    offer     = var.os_publisher == "redhat" ? "RHEL" : "UbuntuServer"
    sku       = var.os_publisher == "redhat" ? "8-LVM" : "18.04-LTS"
    version   = "latest"
  }
}