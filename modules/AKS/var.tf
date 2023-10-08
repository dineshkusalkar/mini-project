variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
  
}

variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
  
}

variable "location" {
  type        = string
  description = "Resources location in Azure"
  default     = "eastus"
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

variable "vm_size" {
  type        = string
  description = "vm_size"
  default     = "Standard_DS2_v2"
}

variable "vm_type" {
  type        = string
  description = "vm_type"
  default     = "VirtualMachineScaleSets"
}