variable "domain_name" {
  description = "Domain name for the DNS record"
  default     = "i-have-no-idea-what-i-am-doing.com"
}

resource "aws_route53_zone" "example_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "example_record" {
  zone_id = aws_route53_zone.example_zone.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web-server.public_ip]
}