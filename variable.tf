variable "subscription_id" {

  type        = string

  description = "Azure Subscription ID from ServiceNow"

}
 
variable "environment" {

  type        = string

  description = "Environment tag from ServiceNow"

}
 
variable "resource_group" {

  type = string

}
 
variable "resource_group_region" {

  type = string

}
 
 
variable "virtual_network_name" {

  type = string

}
 
variable "vnet_address_prefix" {

  type = list(string)

}
 
variable "subnet_name" {

  type = string

}
 
variable "subnet_address_prefix" {

  type = list(string)

}
 
variable "nic_name" {
    default = "testnic"

  type = string

}
 
variable "ip_config_name" {

  type    = string

  default = "internal"

}
 
variable "private_ip_allocation" {

  type    = string

  default = "Dynamic"

}
 
variable "private_ip_address" {

  type    = string

  default = null

}
 
variable "virtual_machine_name" {

  type = string

}
 
variable "vm_size" {
    default = "Standard_B1s"

  type = string

}
 
variable "admin_username" {

  type = string
  default = "azureuser"

}
 
variable "ssh_public_key_path" {
    default = "./ssh/id_rsa.pub"

  type = string

}
 
variable "os_disk_caching" {

  type    = string

  default = "ReadWrite"

}
 
variable "os_disk_storage_type" {

  type    = string

  default = "Standard_LRS"

}


variable "gallery_name" {

  type    = string

  default = "my_test_gallery" # Hardcoded for testing
}

variable "image_name" {

  type    = string

  default = "my_test_image" # Hardcoded for testing
}

variable "image_version" {

  type    = string
  
  default = "1.0.0" # Hardcoded for testing
}

 