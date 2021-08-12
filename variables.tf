variable "ibmcloud_api_key" {
  description = "Cloud API key to be able to control resources"
}

variable "basename" {
  description = "Prefix for all resources"
}

variable "ssh_key_name" {
  description = "Name of the existing SSH key uploaded into VPC"
}

variable "region" {
  description = "IBM Cloud region"
  default = "eu-de"
}

variable "zone" {
  description = "Particular availability zone"
  default = "eu-de-1"
}
