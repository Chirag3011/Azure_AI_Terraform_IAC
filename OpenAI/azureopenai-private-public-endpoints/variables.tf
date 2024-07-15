variable "openai_name" {
  type = string
}

variable "openai_location" {
  type = string
}

variable "openai_resource_group_name" {
  type = string
}

variable "openai_customsubdomain_name" {
  type = string
}

variable "cognitive_deployment_name" {
  type = string
}

variable "private_endpoint" {
  type = bool
  default = true
}