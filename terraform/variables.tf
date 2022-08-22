variable "databricks_account_username" {
  type      = string
  sensitive = true
}
variable "databricks_account_password" {
  type      = string
  sensitive = true
}
variable "databricks_account_id" {
  type      = string
  sensitive = true
}

variable "aws_access_key_id" {
  type      = string
  sensitive = true
}
variable "aws_secret_access_key" {
  type      = string
  sensitive = true
}

variable "aws_region" {
  default = "us-west-2"
}

variable "number_of_public_subnets" {
  default = 2
}

variable "number_of_private_subnets" {
  default = 2
}

variable "vpc_name" {
  default = "data-science-vpc"
}

variable "vpc_cidr_block" {
  default = "10.4.0.0/16"
}

variable "workspace_name" {}
