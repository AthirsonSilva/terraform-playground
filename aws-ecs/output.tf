output "public_ip" {
  value = aws_ecs_task_definition.task.arn
}

# Output Container ID
output "container_ip" {
  value = aws_ecs_service.service.id
}

# Output ECR cluster ID
output "cluter_id" {
  value = aws_ecs_cluster.cluster.id
}