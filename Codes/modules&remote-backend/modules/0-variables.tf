variable "env" {
  # default = "${path.module}" => ERROR: Variables not allowed
  default = "dev"
}

variable "rg_name" {
    type = string
    default = "terraform-rg"
}

variable "rg_location" {
  type = string
  default = "centralindia"
}

variable "vnet_address" {
  type = list(string)
  default = [ "172.31.0.0/16" ]
}

variable "private_subnet_range" {
  type = list(string)
  default = [ "172.31.0.0/24", "172.31.2.0/24", "172.31.4.0/24" ]
}

variable "public_subnet_range" {
  type = list(string)
  default = [ "172.31.1.0/24" ]
}

variable "vnet_name" {
  type = string
  default = "terraform-vnet"
}


variable "private-subnet-tags" {
  type = map(any)
 default = {"Subnet" = "Private-1"
 "Kem" = "Valentine"}

}

# variable "public-subnet-tags" {
#   type = map(any)
# }