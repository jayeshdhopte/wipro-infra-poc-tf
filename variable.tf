variable "subscription_id" {

  type        = string

  description = "Azure Subscription ID from ServiceNow"

}
 
variable "environment" {

  type        = string

  description = "Environment tag from ServiceNow"

}
 
variable "resource_group_name" {

  type = string

}
 
variable "location" {

  type = string

}
 
 
variable "vnet_name" {

  type = string

}
 
variable "address_space" {

  type = list(string)

}
 
variable "subnet_name" {

  type = string

}
 
variable "subnet_prefix" {

  type = list(string)

}
 
variable "nic_name" {

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
 
variable "vm_name" {

  type = string

}
 
variable "vm_size" {

  type = string

}
 
variable "admin_username" {

  type = string
  default = "azureuser"

}
 
variable "ssh_public_key_path" {

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
 