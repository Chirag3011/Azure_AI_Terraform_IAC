resource "azurerm_cognitive_account" "openAI" {
  name                          = var.openai_name
  location                      = var.openai_location
  resource_group_name           = var.openai_resource_group_name
  kind                          = "OpenAI"
  sku_name                      = "S0"
  public_network_access_enabled = var.private_endpoint
  custom_subdomain_name         = var.openai_customsubdomain_name
}

resource "azurerm_cognitive_deployment" "openAI_cognitive_deployement" {
  name                 = var.cognitive_deployment_name
  cognitive_account_id = azurerm_cognitive_account.openAI.id
  model {
    format  = "OpenAI"
    name    = "gpt-35-turbo"
    version = "0301"
  }

  scale {
    type = "Standard"
  }
}

resource "azurerm_virtual_network" "openai-vnet" {
  count               = var.private_endpoint ? 0 : 1
  name                = "vnet01"
  address_space       = ["10.0.0.0/24"]
  location            = var.openai_location
  resource_group_name = var.openai_resource_group_name
}

resource "azurerm_subnet" "openai-subnet" {
  count                = var.private_endpoint ? 0 : 1
  name                 = "snet01"
  resource_group_name  = var.openai_resource_group_name
  virtual_network_name = azurerm_virtual_network.openai-vnet[count.index].name
  address_prefixes     = ["10.0.0.0/25"]
}

resource "azurerm_private_endpoint" "openai-pe01" {
  count               = var.private_endpoint ? 0 : 1
  name                = "pe-openai-we"
  location            = var.openai_location
  resource_group_name = var.openai_resource_group_name
  subnet_id           = azurerm_subnet.openai-subnet[count.index].id

  private_service_connection {
    name                           = "pe-openai-we"
    private_connection_resource_id = azurerm_cognitive_account.openAI[count.index].id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.openai-pdns[count.index].id]
  }
}

resource "azurerm_private_dns_zone" "openai-pdns" {
  count               = var.private_endpoint ? 0 : 1
  name                = "privatelink.openai.azure.com"
  resource_group_name = var.openai_resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "openai-pdns-vnetlink" {
  count                 = var.private_endpoint ? 0 : 1
  name                  = "openai-vnet-link"
  resource_group_name   = var.openai_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.openai-pdns[count.index].name
  virtual_network_id    = azurerm_virtual_network.openai-vnet[count.index].id
}
