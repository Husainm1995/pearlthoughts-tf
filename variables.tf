variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  default     = "husain_vpc"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
  type        = string
}
