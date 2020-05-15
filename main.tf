provider "azurerm"{
    version = "2.5.0"
    features {}
}

terraform{
    backend "azurerm"{
        resource_group_name = "terraform_resource_group_blobstore"
        storage_account_name = "tfstoragemuzdalifa"
        container_name = "tfstate"
        key = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "terraform_test" {
    name = "terraform_main_resource_group"
    location = "West Europe"
  
}

resource "azurerm_container_group" "terraform_container_group" {
    name = "weatherapi"
    location = "West Europe" //alternativelly you can use:
    //location = azurerm_resource_group.terraform_test.location
    //resource_group_name = "terraform_main_resource_group"
    resource_group_name = azurerm_resource_group.terraform_test.name
  
 

    ip_address_type = "public"
    dns_name_label = "weatherwebapitf"
    os_type = "Linux"

    container {
        name = "weatherapi"
        image = "muzdalifa/weatherapi"
        cpu = "1"
        memory = "1"

        ports {
            port = 80
            protocol = "TCP"
        }
    }
}




