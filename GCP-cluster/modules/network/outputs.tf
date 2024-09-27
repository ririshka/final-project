output "subnet_self_link" {
  description = "Self link of the Subnet"
  value       = google_compute_subnetwork.cluster_subnet.self_link
}

output "vpc_network_self_link" {
  description = "Self link of the VPC network"
  value       = google_compute_network.vpc.self_link
}