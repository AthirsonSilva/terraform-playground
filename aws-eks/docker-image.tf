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

# Create a docker image
resource "docker_image" "nginx_image" {
  name = var.image
}