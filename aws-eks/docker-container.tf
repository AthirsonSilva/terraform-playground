# Create an ECS cluster
# This cluster will run the ECS service
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "my-ecs-cluster"
}

# Create an ECR repository
# This repository will store the docker image
resource "aws_ecr_repository" "ecr_repo" {
  name         = "my-ecr-repo"
  force_delete = true
}

resource "null_resource" "push_to_ecr" {
  provisioner "local-exec" {
    command = <<EOF
      $(aws ecr get-login --no-include-email)
      docker tag ${docker_image.nginx_image.name} ${aws_ecr_repository.ecr_repo.repository_url}:latest
      docker push ${aws_ecr_repository.ecr_repo.repository_url}:latest
    EOF
  }

  depends_on = [docker_image.nginx_image]
}

# Create an ECS task definition
# This task definition will run the docker container created above
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "my-ecs-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.container_name}",
      "image": "${var.image}",
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80,
          "protocol": "tcp"
        }
      ],
      "cpu": 256,
      "memory": 512
    }
  ]
  DEFINITION
}

# Create an ECS service
# This service will run the task definition created above
resource "aws_ecs_service" "ecs_service" {
  name            = "my-ecs-service"
  cluster         = aws_eks_cluster.eks_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 1

  network_configuration {
    security_groups = [aws_security_group.security_group.id]
    subnets         = aws_subnet.demo_public_subnet[*].id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    container_name   = var.container_name
    container_port   = 80
  }

  depends_on = [aws_ecs_task_definition.ecs_task_definition]
}

