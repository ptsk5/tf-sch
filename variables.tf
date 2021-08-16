variable "ibmcloud_api_key" {
  description = "Cloud API key to be able to control resources"
}

variable "basename" {
  description = "Prefix for all resources"
  default = "simple-example"
}

variable "region" {
  description = "IBM Cloud region"
  default = "eu-de"
}

variable "zone" {
  description = "Particular availability zone"
  default = "eu-de-1"
}
