terraform {
  backend "s3" {
    bucket  = "tf-s3-bkt-state-backup-a1"
    key     = "backend/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}