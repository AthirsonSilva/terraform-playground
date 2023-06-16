# Output ECR repository URL
output "ecr_repo_url" {
  value = aws_ecr_repository.ecr_repo.repository_url
}

# Output ECS cluster name
output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

# Output ECS service name
output "ecs_service_name" {
  value = aws_ecs_service.ecs_service.name
}