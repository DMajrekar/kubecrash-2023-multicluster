variable "region" {
  type        = string
  default     = "FRA1"
  description = "The region to provision the cluster against"
}

variable "name_prefix" {
  description = "Prefix to append to the name of resources being created"
  type        = string
  default     = "tf-template-"
}

variable "cluster_node_size" {
  type        = string
  default     = "g4s.kube.medium"
  description = "The size of the nodes to provision. Run `civo size list` for all options"
}

variable "cluster_node_count" {
  description = "Number of nodes in the default pool"
  type        = number
  default     = 3
}

variable "kubernetes_api_access" {
  description = "List of Subnets allowed to access the Kube API"
  type        = list(any)
  default     = ["0.0.0.0/0"]
}

variable "argocd_path" {
    type = string
  
}