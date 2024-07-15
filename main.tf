module "cognitive_search_module" {
  source = "./cognitive_search"
  resource_group_name = "chirag"
  existing_resource_group_name = "chirag"
}

module "cognitive_services_module" {
  source = "./cognitive_services"
  resource_group_name = "chirag"
  existing_resource_group_name = "chirag"
}

module "endpoint_module" {
  source = "./OpenAI/azureopenai-private-public-endpoints"
  openai_name = "OpenAI"
  openai_resource_group_name = "chirag"
  openai_location = "centralIndia"
  cognitive_deployment_name = "cg_deployment_01"
  openai_customsubdomain_name = "openai_cognitive"
}