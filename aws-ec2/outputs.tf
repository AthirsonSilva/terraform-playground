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