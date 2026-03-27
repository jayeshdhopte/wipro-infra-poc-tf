# ==========================================
# 1. CORE CONFIGURATION
# ==========================================
variable "subscription_id" { 
  description = "Azure Subscription ID"
  type        = string 
}

variable "environment" { 
  description = "Environment tag from ServiceNow"
  type        = string 
}

# ==========================================
# 2. SERVICENOW DYNAMIC CHOICES (Exists vs. Do Not Exist)
# ==========================================
variable "rg_choice" { type = string }
variable "vnet_choice" { type = string }
variable "subnet_choice" { type = string }
variable "nsg_choice" { type = string }
variable "nic_choice" { type = string }
variable "os_disk_choice" { type = string }

# ==========================================
# 3. RESOURCE GROUP
# ==========================================
variable "resource_group" { type = string }
variable "resource_group_region" { type = string }

# ==========================================
# 4. VIRTUAL NETWORK & SUBNET
# ==========================================
variable "virtual_network_name" { type = string }
variable "vnet_address_prefix" { type = list(string) }

variable "subnet_name" { type = string }
variable "subnet_address_prefix" { type = list(string) }

# ==========================================
# 5. NETWORK SECURITY GROUP & RULES
# ==========================================
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

# ==========================================
# 6. PUBLIC IP
# ==========================================
variable "public_ip_required" { 
  description = "Toggle to create a public IP"
  type        = string 
}
variable "public_ip_name" { type = string }
variable "pip_allocation_method" { type = string }

# ==========================================
# 7. NETWORK INTERFACE
# ==========================================
variable "nic_name" { type = string }
variable "ip_config_name" { type = string }
variable "private_ip_allocation" { type = string }

# ==========================================
# 8. VIRTUAL MACHINE
# ==========================================
variable "virtual_machine_name" { type = string }
variable "vm_size" { type = string }
variable "admin_username" { type = string }

# ==========================================
# 9. OS DISK
# ==========================================
variable "os_managed_disk_id" { type = string }
variable "os_disk_caching" { type = string }
variable "os_storage_account_type" { type = string }

# ==========================================
# 10. IMAGE REFERENCE (Standard Marketplace)
# ==========================================
variable "operating_system_publisher" { type = string }
variable "image_offer" { type = string }
variable "image_sku" { type = string }

# ==========================================
# 11. SHARED IMAGE GALLERY (Conditional)
# ==========================================
variable "use_shared_image" {
  description = "Flag to use shared image"
  type        = bool
  default     = false
}
variable "shared_image_version" { type = string }
variable "image_definition_name" { type = string }
variable "shared_gallery" { type = string }