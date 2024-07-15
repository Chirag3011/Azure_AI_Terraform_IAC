resource "random_string" "azurerm_search_service_name" {
  length  = 25
  upper   = false
  numeric = false
  special = false
}

resource "azurerm_search_service" "search" {
  name                = random_string.azurerm_search_service_name.result
  location            = var.create_new_resource_group ? var.resource_group_location : var.existing_resource_group_location
  resource_group_name = var.create_new_resource_group ? var.resource_group_name : var.existing_resource_group_name
  sku                 = var.sku
  replica_count       = var.replica_count
  partition_count     = var.partition_count
}

output "search_service_name" {
  value = azurerm_search_service.search.name
}

output "search_service_id" {
  value = azurerm_search_service.search.id
}