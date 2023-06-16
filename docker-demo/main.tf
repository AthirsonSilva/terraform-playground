variable "image" {
  type        = string
  description = "Docker image name"
  default     = "nginx:latest"
}

variable "container_name" {
  type        = string
  description = "Docker container name"
  default     = "web-server"
}

resource "docker_image" "nginx_image" {
  name = var.image
}

resource "docker_container" "nginx_container" {
  name  = var.container_name
  image = docker_image.nginx_image.image_id

  ports {
    internal = 80
    external = 8080
  }
}

output "container_name" {
  value = docker_container.nginx_container.name
}
