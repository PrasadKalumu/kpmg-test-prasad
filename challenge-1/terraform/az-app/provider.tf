# Pr# Create Linux Virtual Machine # 

terraform {
  required_version = "~> 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.77"
    }
    local = {
      source  = "hashicorp/local"
      version = "~>2.4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "local" {

}