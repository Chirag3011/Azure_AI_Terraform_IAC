resource "azurerm_resource_group" "rg" {
  count    = var.create_new_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_cognitive_account" "cognitive_service" {
  name                = "CognitiveService-${random_string.azurerm_cognitive_account_name.result}"
  location            = var.create_new_resource_group ? azurerm_resource_group.rg[0].location : var.existing_resource_group_location
  resource_group_name = var.create_new_resource_group ? azurerm_resource_group.rg[0].name : var.existing_resource_group_name
  sku_name            = var.sku
  kind                = "CognitiveServices"
  depends_on = [ azurerm_resource_group.rg ]
}

output "resource_group_name" {
  value = var.create_new_resource_group ? azurerm_resource_group.rg[0].name : var.existing_resource_group_name
}

output "azurerm_cognitive_account_name" {
  value = azurerm_cognitive_account.cognitive_service.name
}

resource "random_string" "azurerm_cognitive_account_name" {
  length  = 13
  lower   = true
  numeric = false
  special = false
  upper   = false
}
