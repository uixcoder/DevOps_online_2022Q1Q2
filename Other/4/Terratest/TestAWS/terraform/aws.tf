provider "aws" {
  profile = "Personal"
  region  = "eu-north-1"
}
# terraform {
#   backend "s3" {
#     bucket         = "igeocitizen-terraform-state"
#     key            = "test/terraform.tfstate"
#     region         = "eu-north-1"
#     encrypt        = true
#     dynamodb_table = "igeocitizen-lock-table-test"
#   }
# }
