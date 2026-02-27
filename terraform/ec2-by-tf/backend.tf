terraform {
  backend "s3" {
    bucket  = "tf-s3-bkt-state-backup-a2"
    key     = "backend/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
