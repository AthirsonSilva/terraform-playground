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

# Output DNS record name
output "dns_record" {
  value = aws_route53_record.dns_record.name
}

# Output DNS zone ID
output "dns_zone_id" {
  value = aws_route53_zone.dns_zone.zone_id
}

# Output DNS zone name
output "dns_zone_name" {
  value = aws_route53_zone.dns_zone.name
}