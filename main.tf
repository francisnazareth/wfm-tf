# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.91"
    }
  }

  required_version = ">= 1.0"
}

provider "azurerm" {

  features {
   }
}

data "azurerm_client_config" "current" {}

output "current_client_id" {
  value = data.azurerm_client_config.current.client_id
}

output "current_tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "current_subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}

output "current_object_id" {
  value = data.azurerm_client_config.current.object_id
}

module "route-table" {
   source               = "./route-table"
   rg-name              = var.rg-name
   rg-location          = var.rg-location
   prod-vnet-address-space = var.prod-vnet-address-space
   firewall-private-ip  = module.firewall.firewall-private-ip
   env                   = var.env
   createdby             = var.createdby
   creationdate          = var.creationdate
}

module "route-table-association" {
   source                = "./route-table-association" 
   route-table-id        = module.route-table.route-table-id 
   aks-subnet-id         = var.aks-subnet-id
}

module "aks" {
   source                = "./aks"
   env                   = var.env
   createdby             = var.createdby
   creationdate          = var.creationdate
   customer-name         = var.customer-name
   rg-name               = var.rg-name
   rg-location           = var.rg-location
   aks-subnet-id         = var.aks-subnet-id
   la-workspace-resource-id = var.la-workspace-id
   aks-vm-size           = var.aks-vm-size
   depends_on            = [module.route-table-association]
}

module "firewall" {
   source                = "./firewall"
   rg-name               = var.rg-name
   rg-location           = var.rg-location
   firewall-snet-id      = var.firewall-subnet-id
   la-workspace-id       = var.la-workspace-id
   customer-name         = var.customer-name
   env                   = var.env
   createdby             = var.createdby
   creationdate          = var.creationdate
   prod-vnet-address-space = var.prod-vnet-address-space
}
