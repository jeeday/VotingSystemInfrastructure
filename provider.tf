terraform {
  backend "s3" {
    bucket = "devops-terraform-state-files"
    key    = "project2/state.tfstate"
    region = "eu-west-2"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"

    }

  }

}
provider "aws" {

  profile = "default"
  region  = "eu-west-2"
}