variable "location" {
  type        = string
  description = "Location used to deploy the resources"
  default     = "westcentralus"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
  default = {
    environment = "test"
    managed_by  = "terratest"
  }
}
