variable "create_new_resource_group" {
  type        = bool
  description = "Set to true to create a new resource group, or false to use an existing one."
  default     = false
}

variable "resource_group_location" {
  type        = string
  description = "Location for all resources when creating a new resource group."
  default     = "eastus"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the new resource group to be created."
}

variable "existing_resource_group_name" {
  type        = string
  description = "Name of the existing resource group to use when create_new_resource_group is set to false."
}

variable "existing_resource_group_location" {
  type        = string
  description = "Location of the existing resource group when create_new_resource_group is set to false."
  default     = "eastus"
}

variable "sku" {
  type        = string
  description = "The sku name of the Azure Analysis Services server to create. Choose from: B1, B2, D1, S0, S1, S2, S3, S4, S8, S9. Some skus are region specific. See https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-overview#availability-by-region"
  default     = "S0"
}