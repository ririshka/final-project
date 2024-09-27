module "network" {
  source            = "./modules/network"
  net_project       = "inner-nuance-332319"
  cluster_project   = "inner-nuance-332319"
  network_name      = "my-vpc"
  subnet_name       = "gke-subnet"
  region            = "us-central1"
  pods_range_name   = "gke-pods"
  pods_ip_range     = "10.1.4.0/22"  # Измените здесь, чтобы избежать конфликта
  svc_range_name    = "gke-services"
  svc_ip_range      = "10.1.32.0/20" # Измените здесь, чтобы избежать конфликта
  ip_cidr_range     = "10.0.0.0/16"  # Основной IP диапазон
}


module "gke" {
  source              = "./modules/gke"
  cluster_project     = "inner-nuance-332319"
  cluster_name        = "my-gke-cluster"
  region              = "us-central1"
  network_self_link   = module.network.vpc_network_self_link
  subnet_self_link    = module.network.subnet_self_link
  pods_range_name     = "gke-pods"
  svc_range_name      = "gke-services"
  node_service_account = "aiperi@inner-nuance-332319.iam.gserviceaccount.com"
  initial_node_count  = 1  # Уменьшение количества нод до 1
  machine_type        = "n1-standard-1"  # Уменьшение типа машины
  disk_size_gb        = 50  # Уменьшение размера диска до 50 ГБ
  disk_type           = "pd-standard"  # Использование стандартного диска
}