#Vnets
variable "vnet_name" {
  type        = string
  description = "Virtual network name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}
variable "resource_group_name_common" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "address_space" {
  type        = list
  description = "Address space"
}

variable "tags" {
  type        = map
  description = "Tags for the resource"
}

#Subnets
variable "subnets" {
  type = map
  default = {} 
}

#Postgre flexible
variable "postgre_flexible_subnets" {
  type = map
  default = {} 
}