# Create an ECS task definition
resource "aws_ecs_task_definition" "my_task_definition" {
  family                = "my-task-definition"
  container_definitions = <<EOF
  [
    {
      "name": "my-container",
      "image": "${aws_ecr_repository.my_repo.repository_url}:latest",
      "cpu": 256,
      "memory": 512,
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ]
    }
  ]
  EOF
}


# Create an ECS service
resource "aws_ecs_service" "my_service" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  desired_count   = 1

  # network_configuration {
  #   subnets         = [aws_subnet.demo_public_subnet.id]
  #   security_groups = [aws_security_group.security_group.id]
  # }
}
