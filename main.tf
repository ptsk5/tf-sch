resource ibm_is_vpc "vpc" {
  name = "${var.basename}-vpc"
}

# public gateway
resource "ibm_is_public_gateway" "public_gw" {
    name = "${var.basename}-public-gw"
    vpc = "${ibm_is_vpc.vpc.id}"
    zone = "${var.zone}"

    //User can configure timeouts
    timeouts {
        create = "90m"
    }
}

# Kubernetes subnet
resource ibm_is_subnet "k8s-subnet" {
  name = "${var.basename}-k8s-subnet"
  vpc  = "${ibm_is_vpc.vpc.id}"
  zone = "${var.zone}"
  total_ipv4_address_count = 256

  public_gateway = "${ibm_is_public_gateway.public_gw.id}"
}
