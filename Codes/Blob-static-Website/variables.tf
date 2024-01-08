variable "env" {
  # default = "${path.module}" => ERROR: Variables not allowed
  default = "dev"
}

variable "rg_name" {
    type = string
    default = "terraform-rg-v2"
}

variable "rg_location" {
  type = string
  default = "centralindia"
}

variable "storage_name" {
  type = string
  default = "qwertyuio9876543"
}

variable "index_html" {
  type = string
  default = "C:/Users/anana/Downloads/home.html"
}

variable "error" {
  type = string
  default = "C:/Users/anana/Downloads/error.html"
}

variable "folder" {
  type = string
  default = "C:/Users/anana/Desktop/Simple-Timer"
}