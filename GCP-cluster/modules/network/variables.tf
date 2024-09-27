variable "net_project" {
  description = "ID сетевого проекта"
  type        = string
}

variable "cluster_project" {
  description = "ID проекта кластера"
  type        = string
}

variable "network_name" {
  description = "Имя общего VPC"
  type        = string
}

variable "subnet_name" {
  description = "Имя подсети"
  type        = string
}

variable "region" {
  description = "Регион"
  type        = string
}

variable "pods_range_name" {
  description = "Имя вторичного диапазона IP для pod'ов"
  type        = string
}

variable "pods_ip_range" {
  description = "Диапазон IP для pod'ов"
  type        = string
}

variable "svc_range_name" {
  description = "Имя вторичного диапазона IP для сервисов"
  type        = string
}

variable "svc_ip_range" {
  description = "Диапазон IP для сервисов"
  type        = string
}

variable "ip_cidr_range" {
  description = "Primary CIDR range for the subnet"
  type        = string
}