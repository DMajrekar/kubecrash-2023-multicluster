variable "civo_token" {}

variable "region" {
  type        = string
  default     = "LON1"
  description = "The region to provision the cluster against"
}

variable "name_prefix" {
  description = "Prefix to append to the name of the cluster being created"
  type        = string
  default     = "lon-demo"
}


# Firewall Access
variable "kubernetes_api_access" {
  description = "List of Subnets allowed to access the Kube API"
  type        = list(any)
  default     = ["0.0.0.0/0"]
}

variable "cluster_web_access" {
  description = "List of Subnets allowed to access port 80 via the Load Balancer"
  type        = list(any)
  default     = ["0.0.0.0/0"]
}

variable "cluster_websecure_access" {
  description = "List of Subnets allowed to access port 443 via the Load Balancer"
  type        = list(any)
  default     = ["0.0.0.0/0"]
}

variable "object_store_enabled" {
  description = "Should an object store be configured"
  type = bool
  default = false
}

variable "object_store_size" {
  description = "Size of the Object Store to create (multiples of 500)"
  type        = number
  default     = 500
}

variable "object_store_prefix" {
  description = "Prefix to append to the name of the object store being created"
  type        = string
  default     = "tf-template-"
}

# Output
