variable "region" {
  description = "aws region to use"
  type = string
  default = "us-east-2"
}

variable "environment" {
  description = "Environment"
  type = string
  default = "test"
}

variable "name" {
  description = "Name to use for resources"
  type = string
  default = "altir"
}

variable "tags" {
  description = "tags"
  type = map(string)

  default = {
    "managed_by" = "terraform"
  }
}

# VPC variables
variable "vpc_cidr" {
  description = "CIDR range of VPC"
  type        = string
  default     = "10.0.0.0/16"
}