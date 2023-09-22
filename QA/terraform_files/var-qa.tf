variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
  default     = "mini-project"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
  default     = "eastus"
}
variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
  default     = "AKS"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.26.6"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
  default     = 1
}
