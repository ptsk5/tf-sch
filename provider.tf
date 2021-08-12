terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.29.0"
    }
    kubernetes = { 
      source = "hashicorp/kubernetes" 
      version = "2.4.1" 
    }
    helm = { 
      source = "hashicorp/helm" 
      version = "2.2.0" 
    }
  }
}


provider "ibm" {
  ibmcloud_api_key      = "${var.ibmcloud_api_key}"
#  generation            = 1
  region                = "${var.region}"
}
