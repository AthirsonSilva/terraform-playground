# Create an ECS cluster
resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ecs-cluster"
}

# Create an ECR repository
resource "aws_ecr_repository" "my_repo" {
  name         = "my-ecr-repo"
  force_delete = true
}

# Authenticate Docker with the ECR repository
resource "aws_ecr_repository_policy" "my_repo_policy" {
  repository = aws_ecr_repository.my_repo.name

  policy = file("./scripts/repository-policy.json")
}

# Build and push the Docker image to ECR
resource "null_resource" "build_and_push_image" {
  depends_on = [
    aws_ecr_repository.my_repo,
  ]

  provisioner "local-exec" {
    command = templatefile("./scripts/image-push.tpl", {
      region   = "sa-east-1",
      repo_url = aws_ecr_repository.my_repo.repository_url,
    })
  }
}
