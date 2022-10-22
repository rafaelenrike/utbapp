terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.28.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg_terraform"
    storage_account_name = "terraformstorageutb"
    container_name       = "tfstatesdevops"
    key                  = "terraformgithub.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

variable "imagebuild" {
  type = string
  description = "the latest image build version"
}

resource "azurerm_resource_group" "rg_utbapp" {
  name = "rg_utbapp" # this is the name on azure
  location = "eastus" # data center location on azure
}

resource "azurerm_container_group" "tf_cg_utb" {
  name                  = "utbapp"
  location              = azurerm_resource_group.rg_utbapp.location #utilising the resource group
  resource_group_name   = azurerm_resource_group.rg_utbapp.name #utilising the resource group

  ip_address_type       = "Public"
  dns_name_label        = "rafaelenrike-utb" #friendly name we want to give our domain
  os_type               = "Linux"

  # Specify the container information
  container {
    name = "utbapp"
    image = "rafaelenrike/utbapp:${var.imagebuild}"
    cpu = "1"
    memory = "1"

    ports {
        port = 80
        protocol = "TCP"
    }
  }
}
