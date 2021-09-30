#Vnet
vnet_name = "VNET-retail-dev"
resource_group_name = "rg-common-test-networking-nonprod"
resource_group_name_common = "RG-COMMON-NETWORKING-AZDNS"
location = "westeurope"
address_space = ["10.142.0.0/24", "10.142.1.0/24"]
tags = {}

#Subnets
subnets = {
    "subnet01" = {
        name              = "VNET-retail-SNET-COMMON_dev"
        address_prefixes  = ["10.142.0.0/27"]
        enforce           = true
    },
    "subnet02" = {
        name              = "VNET-retail-platformx-SNET-IT-TOOLS_dev"
        address_prefixes  = ["10.142.0.32/27"]
        enforce           = true
    },
    "subnet03" = {
        name              = "VNET-retail-platformx-SNET-AKS_dev"
        address_prefixes  = ["10.142.0.96/27"]
        enforce           = true
    },
    "subnet05" = {
        name              = "VNET-retail-platformx-SNET-STORAGE_dev"
        address_prefixes  = ["10.142.0.192/27"]
        enforce           = true
    },
    "subnet06" = {
        name              = "VNET-retail-platformx-SNET-REDIS_dev"
        address_prefixes  = ["10.142.0.64/27"]
        enforce           = true
    },
    "subnet07" = {
        name              = "VNET-retail-platformy-SNET-IT-TOOLS_dev"
        address_prefixes  = ["10.142.1.0/27"]
        enforce           = true
    },
    "subnet08" = {
        name              = "VNET-retail-platformy-SNET-AKS_dev"
        address_prefixes  = ["10.142.1.32/27"]
        enforce           = true
    },
    "subnet09" = {
        name              = "VNET-retail-platformy-SNET-STORAGE_dev"
        address_prefixes  = ["10.142.1.64/27"]
        enforce           = true
    },
    "subnet10" = {
        name              = "VNET-retail-platformy-SNET-REDIS_dev"
        address_prefixes  = ["10.142.1.96/27"]
        enforce           = true
    }
}

#Postgre flexible subnet
postgre_flexible_subnets = {
    "critical01" = {
        name             = "VNET-retail-platformx-SNET-POSTGRESQL_CRITICAL_dev"
        address_prefixes = ["10.142.0.128/27"]
    },
    "non-critical01" = {
        name             = "VNET-retail-platformx-SNET-POSTGRESQL_NON_CRITICAL_dev"
        address_prefixes = ["10.142.0.160/27"]
    },
    "critical02" = {
        name             = "VNET-retail-platformy-SNET-POSTGRESQL_CRITICAL_dev"
        address_prefixes = ["10.142.1.128/27"]
    },
    "non-critical02" = {
        name             = "VNET-retail-platformy-SNET-POSTGRESQL_NON_CRITICAL_dev"
        address_prefixes = ["10.142.1.160/27"]
    }
}
