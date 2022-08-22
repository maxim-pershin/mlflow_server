variable "AWS_ACCESS_KEY_ID" {
  type      = string
  sensitive = true
}
variable "AWS_SECRET_ACCESS_KEY" {
  type      = string
  sensitive = true
}

variable "AWS_SESSION_TOKEN" {
  type      = string
  sensitive = true
  description = "Temporary session token used to create instances"
}

variable "AWS_REGION" {
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
