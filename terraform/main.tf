terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "application" {
  name         = var.image_name
  keep_locally = true
}

resource "docker_container" "hello_world" {
  name  = var.container_name
  image = docker_image.application.image_id


  ports {
    internal = var.internal_port
    external = var.app_port
  }
}