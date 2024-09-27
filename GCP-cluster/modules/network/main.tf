provider "google" {
  project = "inner-nuance-332319"
  region  = "us-central1"
}

resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.net_project
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "cluster_subnet" {
  name       = var.subnet_name
  network    = google_compute_network.vpc.self_link
  project    = var.net_project
  region     = var.region
  ip_cidr_range = var.ip_cidr_range

  secondary_ip_range {
    range_name    = var.pods_range_name
    ip_cidr_range = var.pods_ip_range
  }

  secondary_ip_range {
    range_name    = var.svc_range_name
    ip_cidr_range = var.svc_ip_range
  }
}

resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  network = google_compute_network.vpc.self_link
  region  = var.region
  project = var.net_project
}

resource "google_compute_router_nat" "nat_config" {
  name                       = "nat-config"
  router                     = google_compute_router.nat_router.name
  region                     = var.region
  project                    = var.net_project
  nat_ip_allocate_option     = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
