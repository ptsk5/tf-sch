# Simple terraform example

## K8s cluster in VPC infrastructure with one worker node

- Uses IBM Cloud provider to create VPC infrastructure and the minimal Kubernetes cluster in there
- Uses Kubernetes provider to create a new namespace
- Uses Helm provider to deploy node-red app and exposes it via ingress

## Variables to be configured

- see in `variables.tf` file
  - the deployment targets Frankfurt DC and the first availability zone unless otherwise stated by using `region` and `zone` variable
  - `ibmcloud_api_key` - mandatory variable to control IBM resources
  - `basename` - (optional) usefull prefix which is used for all created resources
