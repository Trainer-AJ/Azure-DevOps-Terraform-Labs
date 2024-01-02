variable "rg-name" {
  default = "TF-Lab-3"
  type = string
}

variable "tags" {
  default     = { environment = "Production", "Author" = "Ananay Ojha" }
  type        = map(string)
  description = "Give vaules in the format  environment = \"Production\""
  # Escape double quotes in the format = \" VALUE \" which eqauls to "VALUE"
}

 variable "location" {
   type    = list(string)
   default = ["EastUS", "central India", "West Europe"]
   validation {
     condition     = length(var.location) >= 3
     error_message = "Provide 3 different region names to create Public IP."
   }
 }

