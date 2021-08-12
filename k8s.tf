# K8s cluster in VPC subnet
resource "ibm_container_vpc_cluster" "k8s-cluster" {
  name              = "${var.basename}-k8s-cluster"
  vpc_id            = "${ibm_is_vpc.vpc.id}"
  flavor            = "cx2.2x4"
  worker_count      = "1"
  zones {
    subnet_id = "${ibm_is_subnet.k8s-subnet.id}"
    name      = "${var.zone}"
  }
}

data "ibm_container_cluster_config" "mycluster" {
  cluster_name_id = "${var.basename}-k8s-cluster"
  admin           = true
  # TODO: This must be included if the cluster is not exist, 
  #    but in case the cluster already exists there is the problem with this dependency which blocks refresh of actual state, so for that case, the block should be commented out
  #    Probably the load_config_file=true option on the provider should be able to deal with this, needs to be tested!
  depends_on = [
      ibm_container_vpc_cluster.k8s-cluster
    ]
}

provider "kubernetes" {
  host                   = "${data.ibm_container_cluster_config.mycluster.host}"
  client_certificate     = "${data.ibm_container_cluster_config.mycluster.admin_certificate}"
  client_key             = "${data.ibm_container_cluster_config.mycluster.admin_key}"
  cluster_ca_certificate = "${data.ibm_container_cluster_config.mycluster.ca_certificate}"
}
resource "kubernetes_namespace" "dev-ns" {
  metadata {
    name = "${var.basename}-dev"
  }
}

provider "helm" {
  kubernetes {
    host                   = "${data.ibm_container_cluster_config.mycluster.host}"
    client_certificate     = "${data.ibm_container_cluster_config.mycluster.admin_certificate}"
    client_key             = "${data.ibm_container_cluster_config.mycluster.admin_key}"
    cluster_ca_certificate = "${data.ibm_container_cluster_config.mycluster.ca_certificate}"
  }
}

resource "helm_release" "node-red" {
  name       = "${var.basename}-node-red"

  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "node-red"
  # version    = ""
  namespace = "${kubernetes_namespace.dev-ns.metadata.0.name}"
  
  set {
    name  = "ingress.enabled"
    value = "true"
  }
  
  set {
    name  = "ingress.hosts"
    value = "{${var.basename}-node-red.${ibm_container_vpc_cluster.k8s-cluster.ingress_hostname}}"
  }
}

output node_red_appingress {
  value = "${var.basename}-node-red.${ibm_container_vpc_cluster.k8s-cluster.ingress_hostname}"
}