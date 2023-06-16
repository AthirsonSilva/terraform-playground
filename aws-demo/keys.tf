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
