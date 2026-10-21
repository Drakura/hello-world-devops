variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "hello-world"
}

variable "image_name" {
  description = "The name of the Docker image"
  type        = string
  default     = "hello-world-image"
}

variable "container_name" {
  description = "The name of the Docker container"
  type        = string
  default     = "hello-world-container"
}

variable "app_port" {
  description = "The port on which the application will be exposed"
  type        = number
  default     = 8081
}

variable "internal_port" {
  description = "The internal port of the application"
  type        = number
  default     = 80
}