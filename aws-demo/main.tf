// Set the default instance type
variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
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
