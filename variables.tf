variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}

variable "project_name" {
  type        = string
  description = "Project name to be used in the beggining of all Name tags"
}

variable "region" {
  type        = string
  description = "AWS region to create the resources"
}

variable "tags" {
  type        = map(any)
  description = "Map of tags"
}

variable "ami" {
  type        = string
  description = "EC2 Image"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance type"

}

variable "key_name" {
  type        = string
  description = "Key pair"

}

variable "local_folder" {
  type        = string
  description = "local diretory of your app folder"

}

variable "private_key" {
  type        = string
  description = "private key diretory"

}