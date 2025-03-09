# main.tf

terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      # version = "..."
    }
  }
  backend "s3" {
    bucket                      = "terrastate"                 # Replace with your Linode bucket name
    key                         = "tf/tfstate"              # Path to store state file
    region                      = "us-ord-1"                   # Replace with your preferred region
    access_key                  = "${access_key}"               # Using variables for security
    secret_key                  = "${secret_key}"                # Using variables for security
    skip_region_validation = true  # All of these skip_* arguements are used since our object storage doesn't implement these additional endpoints
    skip_credentials_validation = true
    skip_requesting_account_id = true
    skip_s3_checksum = true
    #use_path_style            = true                                  # Required for Linode compatibility
    endpoints = {
      s3 = "https://us-ord-1.linodeobjects.com"  # The endpoint for the s3 API based on the region your bucket is located https://techdocs.akamai.com/cloud-computing/docs/access-buckets-and-files-through-urls#cluster-url-s3-endpoint
    }  
  }
}

provider "linode" {
  token = var.linode_token
}

resource "linode_instance" "example" {
  label       = "terraform-linode"
  region      = "us-east"          # Change to your preferred region
  type        = "g6-nanode-1"      # Linode type (size)
  image       = "linode/ubuntu22.04"  # Choose your OS image
  root_pass   = var.root_password  # Use variable for security
}

output "ip_address" {
  value = linode_instance.example.ip_address
}