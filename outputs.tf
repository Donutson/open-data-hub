output "ec2_public_ip" {
  value       = aws_instance.main.public_ip
  description = "EC2 instance public ip addresse"
}
