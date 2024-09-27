output "cluster_name" {
  description = "Имя кластера"
  value       = google_container_cluster.primary.name
}

output "endpoint" {
  description = "IP-адрес мастера кластера"
  value       = google_container_cluster.primary.endpoint
}