terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform { 
  backend "azurerm"  {
    resource_group_name  = "rg-common-nonprod"
    storage_account_name = "satestiacdev"
    container_name       = "network"
    key                  = "network/terraform.tfstate"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  tags                = var.tags
}

#Subnets deployment
resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  
  name                                           = each.value.name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = each.value.address_prefixes
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  
  enforce_private_link_endpoint_network_policies = each.value.enforce
}

#Postgre flexible deployment, delegated subnet
resource "azurerm_subnet" "postgre_flexible_subnets" {
  for_each = var.postgre_flexible_subnets

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
  #Two apply were needed without depends_on
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

#Private DNS zones
resource "azurerm_private_dns_zone" "private_dns_acr" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "private_dns_file" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "private_dns_vault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "private_dns_postgre" {
  name                = "ddbb.private.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

#Private DNS zones virtual network links
resource "azurerm_private_dns_zone_virtual_network_link" "vnl_acr" {
  name                  = "linkacr"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_acr.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnl_file" {
  name                  = "linkfile"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_file.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnl_vault" {
  name                  = "linkvault"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_vault.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnl_postgre" {
  name                  = "linkpostgre"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_postgre.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}