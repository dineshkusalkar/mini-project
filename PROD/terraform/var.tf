variable "resource_group_name" {  
  type        = string
  description = "RG name in Azure"
  default     = "mini-project-PROD"
}

variable "location" {
  type        = string
  description = "Resources location in Azure"
  default     = "eastus"
}

variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
  default     = "AKS-PROD"
}

variable "name" {
  type        = string
  description = "Resources location in Azure"
  default     = "kvdinesh007-PROD"
}