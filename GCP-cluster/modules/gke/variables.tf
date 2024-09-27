variable "cluster_project" {
  description = "ID проекта кластера"
  type        = string
}

variable "cluster_name" {
  description = "Имя кластера"
  type        = string
}

variable "region" {
  description = "Регион"
  type        = string
}

variable "network_self_link" {
  description = "Self link сети VPC"
  type        = string
}

variable "subnet_self_link" {
  description = "Self link подсети"
  type        = string
}

variable "pods_range_name" {
  description = "Имя вторичного диапазона IP для pod'ов"
  type        = string
}

variable "svc_range_name" {
  description = "Имя вторичного диапазона IP для сервисов"
  type        = string
}

variable "machine_type" {
  description = "Тип машины для узлов кластера"
  type        = string
  default     = "e2-standard"
}

variable "node_service_account" {
  description = "Учетная запись службы для узлов кластера"
  type        = string
}

variable "initial_node_count" {
  type    = number
  default = 2  # Например, по умолчанию создаются 3 ноды
}

variable "disk_size_gb" {
  description = "Размер диска для узлов кластера"
  type        = number
  default     = 50  # Пример
}

variable "disk_type" {
  description = "Тип диска для узлов кластера"
  type        = string
  default     = "pd-standard"  # Пример
}