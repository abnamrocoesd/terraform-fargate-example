variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default = "ecs-cluster"
}

variable "profile" {
  description = "Which profile to use"
  default = "default"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default = "vpc"
}

variable "public_subnet_filter" {
  description = "Filter for public subnets"
  default = "*Public*"
}

variable "private_subnet_filter" {
  description = "Filter for private subnets"
  default = "*Private*"
}

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}"]
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.main.id}"

  tags {
    Name = "${var.private_subnet_filter}"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = "${data.aws_vpc.main.id}"

  tags {
    Name = "${var.public_subnet_filter}"
  }
}

variable "app_name" {
  description = "Container name"
  default     = "app"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "adongy/hostname-docker:latest"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 3000
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 2
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}
