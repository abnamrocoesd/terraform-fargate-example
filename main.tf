# Specify the provider and access details

provider "aws" {
  region     = "${var.aws_region}"
  profile    = "${var.profile}"
}

# Fetch AZs in the current region
data "aws_availability_zones" "available" {}

module "fargate" {
  source                               = "github.com/abnamrocoesd/terraform-aws-fargate"
  cluster_name                         = "${var.cluster_name}"
  app_name                             = "${var.app_name}"
  app_image                            = "${var.app_image}"
  fargate_cpu                          = "${var.fargate_cpu}"
  fargate_memory                       = "${var.fargate_memory}"
}
