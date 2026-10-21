output "project_name" {
  description = "The name of the project"
  value       = var.project_name
}

output "container_name" {
  description = "The name of the Docker container"
  value       = docker_container.hello_world.name
}

output "container_id" {
  description = "The ID of the Docker container"
  value       = docker_container.hello_world.id
}

output "image_name" {
  description = "The name of the Docker image"
  value       = docker_image.application.name
}

output "application_url" {
  description = "The URL to access the application"
  value       = "http://localhost:${var.app_port}"
}