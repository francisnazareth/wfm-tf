variable "customer-name" {
  description = "Customer name"
}

variable "location-prefix" {
}

variable "rg-name" {
  description = "Production Resource Group"
}

variable "rg-location" {
  description = "Resource Group Location"
}

variable "env" { 
}

variable "createdby" {
}

variable "creationdate" { 
}

variable "aks-subnet-id" {
}


variable "firewall-subnet-id" {
}

variable "la-workspace-id" {
}

############################ VNET & SUBNETS ###################
#Address range for the Firewall subnet (0-31)
variable "firewall-subnet-address-space" {
}

variable "prod-vnet-address-space" { 
}

#Address range for the AKS subnet 
variable "aks-subnet-address-space" {
}

################ Kubernetes ###############################
variable "aks-vm-size" { 
}

###############  END ######################################
