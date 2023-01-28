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
  default = "techverito"
}

variable "tags" {
  description = "tags"
  type = map(string)

  default = {
    "managed_by" = "terraform"
  }
}