variable "rg_choice" { type = string }
variable "vnet_choice" { type = string }
variable "subnet_choice" { type = string }
variable "nsg_choice" { type = string }
variable "nic_choice" { type = string }
variable "os_disk_choice" { type = string }

variable "resource_group" { type = string }
variable "resource_group_region" { type = string }

variable "virtual_network_name" { type = string }
variable "vnet_address_prefix" { type = list(string) }

variable "subnet_name" { type = string }
variable "subnet_address_prefix" { type = list(string) }

variable "nsg_name" { type = string }

variable "rule_name" { type = string }
variable "rule_priority" { type = number }
variable "rule_direction" { type = string }
variable "rule_access" { type = string }
variable "rule_protocol" { type = string }
variable "source_port_range" { type = string }
variable "destination_port_range" { type = string }
variable "nsg_source_address_prefix" { type = string }
variable "nsg_destination_address_prefix" { type = string }

variable "public_ip_name" { type = string }
variable "pip_allocation_method" { type = string }

variable "nic_name" { type = string }
variable "ip_config_name" { type = string }
variable "private_ip_allocation" { type = string }

variable "os_managed_disk_id" { type = string }
variable "os_disk_caching" { type = string }
variable "os_storage_account_type" { type = string }

# ---------- Shared Image ----------
variable "shared_image_version" {
  description = "Version of the shared image"
  type        = string
}

variable "image_definition_name" {
  description = "Name of the image definition"
  type        = string
}

variable "shared_gallery" {
  description = "Name of the shared image gallery"
  type        = string
}

variable "use_shared_image" {
  description = "Flag to use shared image"
  type        = bool
  default     = false
}

# ---------- VM ----------
variable "virtual_machine_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
}

variable "admin_username" {
  description = "Admin username for VM"
  type        = string
}

# ---------- Image Reference ----------
variable "operating_system_publisher" {
  description = "Image publisher (e.g., RedHat)"
  type        = string
}

variable "image_offer" {
  description = "Image offer (e.g., RHEL)"
  type        = string
}

variable "image_sku" {
  description = "Image SKU"
  type        = string
}

