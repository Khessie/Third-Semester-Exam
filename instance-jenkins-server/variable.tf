variable "aws_region" {
  type        = string
  default     = "eu-west-2"
  description = "Sets the aws region"
}

# variable "access_key" {
#   default = "AKIARQYDZHD2IBQOICNY"
# }

# variable "secret_key" {
#   default = "G3AeOvaUh++HySaPtnGl22NOO7uB2HyYYnfxAU+H"
# }

variable "availability_zone" {
  default = "eu-west-2a"
}

variable "subnet_names" {
  default = ["kubernetes_subnets"]
}

variable "env_prefix" {
  default = "kubernetes"
}

variable "subnet_cidr_block" {
  default = "10.0.10.0/24"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  type    = string

}
