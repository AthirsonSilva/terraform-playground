output "public_ip" {
  value = aws_ecs_task_definition.task.arn
}

# Output Container ID
output "container_ip" {
  value = aws_ecs_service.my_service.id
}

# Output ECR cluster ID
output "cluter_id" {
  value = aws_ecs_cluster.my_cluster.id
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