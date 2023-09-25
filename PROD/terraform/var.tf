variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
  default     = "mini-project-PROD"
}

variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
  default     = "AKS-PROD"
}