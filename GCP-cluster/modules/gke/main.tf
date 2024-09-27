provider "google" {
  project = "inner-nuance-332319"
  region  = "us-central1"
}

resource "google_container_cluster" "primary" {
  project    = var.cluster_project
  name       = var.cluster_name
  location   = var.region
  network    = var.network_self_link
  subnetwork = var.subnet_self_link
  deletion_protection = false 

  initial_node_count = 1  # Уменьшение количества нод до 1

  ip_allocation_policy {
    cluster_secondary_range_name   = var.pods_range_name
    services_secondary_range_name  = var.svc_range_name
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

master_authorized_networks_config {
  cidr_blocks {
    cidr_block   = "192.168.0.109/32"  # Локальный IP-адрес твоего устройства
    display_name = "My Device"
  }
}


  node_config {
    machine_type    = "n1-standard-1"  # Уменьшение типа машины до n1-standard-1
    disk_size_gb    = 50               # Уменьшение размера диска до 50 ГБ
    disk_type       = "pd-standard"    # Использование стандартного диска вместо SSD
    service_account = var.node_service_account
  }
}