terraform {
  backend "s3" {
    bucket         = "shashank-cloud-platform-tfstate"
    key            = "cloud-platform/dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "shashank-cloud-platform-tf-locks"
  }
}
