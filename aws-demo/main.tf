// Set the default instance type
variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

// Create a TLS private key for the EC2 instance
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// Create a key pair for the EC2 instance using the TLS private key
resource "aws_key_pair" "key" {
  key_name   = "web-server-key.pem"
  public_key = tls_private_key.key.public_key_openssh
}

// Set up a security group for the EC2 instance to allow SSH access and HTTP traffic
resource "aws_security_group" "security_group" {
  name        = "web-server-sg"
  description = "Allow SSH and HTTP access"
  vpc_id      = aws_vpc.demo_vpc.id

  ingress {
    description = "All inbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Spin up an EC2 instance
resource "aws_instance" "web-server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.security_group.id]
  subnet_id              = aws_subnet.demo_public_subnet.id

  user_data                   = file("./setup.sh")
  user_data_replace_on_change = true
}

// Output the public IP address of the EC2 instance
output "instance_id" {
  value       = aws_instance.web-server.public_ip
  description = "Public IP of EC2 instance"
}

// Output the public DNS of the EC2 instance
output "public_dns" {
  value       = aws_instance.web-server.public_dns
  description = "Public DNS of EC2 instance"
}

// Output the private key for the EC2 instance
output "private_key" {
  value       = tls_private_key.key.private_key_pem
  description = "Private key for EC2 instance"
  sensitive   = true
}