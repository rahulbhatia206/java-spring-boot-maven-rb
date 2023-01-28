terraform {
  backend "s3" {
    bucket = "techverito-state"
    key = "tf-techverito-project"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
  access_key = "AKIAR7LK3SYTNVKPYJWL"
  secret_key = "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"
}