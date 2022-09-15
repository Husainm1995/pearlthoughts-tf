provider "aws" {
  default_tags {
    tags = {
      Owner   = "Husain"
      Project = "Pearlthoughts"
    }
  }
  region     = var.region
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}