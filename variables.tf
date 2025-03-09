# variables.tf

variable "linode_token" {
  description = "Linode API Token"
  type        = string
  sensitive   = true
}

variable "root_password" {
  description = "Root password for Linode instance"
  type        = string
  sensitive   = true
}
