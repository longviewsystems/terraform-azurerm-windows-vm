
terraform {
  required_version = ">= 1.0.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0, <4.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">=3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.3.0"
    }
  }
}