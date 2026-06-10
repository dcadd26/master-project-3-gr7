output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "application_url" {
  value = "http://${aws_lb.app_alb.dns_name}"
}