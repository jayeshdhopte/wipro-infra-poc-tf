terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
terraform {
  cloud {

    organization = "jayesh-d-org"

    workspaces {
      name = "RITM0010049"
    }
  }
}
provider "azurerm" {
  features {}
  # The subscription ID comes from your ServiceNow payload
  subscription_id = var.subscription_id
}