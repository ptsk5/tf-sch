resource ibm_is_vpc "vpc" {
  name = "${var.basename}-vpc"
}

# Kubernetes subnet
resource ibm_is_subnet "k8s-subnet" {
  name = "${var.basename}-k8s-subnet"
  vpc  = "${ibm_is_vpc.vpc.id}"
  zone = "${var.zone}"
  total_ipv4_address_count = 256
}
