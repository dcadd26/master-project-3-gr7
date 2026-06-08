terraform {
  backend "s3" {
    bucket = "gropu-7-terraform-state"
    key    = "master-project/terraform.tfstate"
    region = "eu-central-1"
  }
}