variable "str_name" {
  type        = string
  description = "Provide a globally unique string for Azure Storage Account name."

  validation {
    condition     = length(var.str_name) >= 3 && length(var.str_name) <= 24
    error_message = "The variable must be between 3 and 24 characters."
  }

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.str_name))
    error_message = "The variable must contain only lower case letters and numbers."
  }
}

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

variable "file" {
  type = string
  default = "Subscribe-Cloud-Portfolio-3.png"
    validation {
    condition     = fileexists(var.file)
    error_message = "The specified file does not exist."
  }
}

