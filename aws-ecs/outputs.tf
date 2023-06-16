output "container_ip" {
  value = aws_ecs_service.my_service.id
}

output "cluter_id" {
  value = aws_ecs_cluster.my_cluster.id
}