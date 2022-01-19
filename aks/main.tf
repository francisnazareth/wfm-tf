
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.customer-name}-${var.env}-we-01"
  location            = var.rg-location
  resource_group_name = var.rg-name
  dns_prefix          = "aks-${var.customer-name}-${var.env}"
  private_cluster_enabled = true

  default_node_pool {
    name       = "nodepool1"
    node_count = 3
    max_pods   = 80
    os_disk_size_gb = 128
    os_disk_type = "Ephemeral"
    availability_zones = [1, 2, 3]
    vm_size    = var.aks-vm-size
    vnet_subnet_id = var.aks-subnet-id
    type           = "VirtualMachineScaleSets" 
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "userDefinedRouting"  
    dns_service_ip     = "172.23.156.10"
    docker_bridge_cidr = "172.17.0.1/24"
    service_cidr       = "172.23.156.0/22" 
  }

  addon_profile {

    azure_policy {
      enabled = true
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = var.la-workspace-resource-id
    }  
  }

  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}
