output "id" {
  description = "The ID of the instance"
  value       = aws_instance.test-ec2.id
}

output "arn" {
  description = "The ARN of the instance"
  value       = aws_instance.test-ec2.arn
}

output "availability_zone" {
  description = "The availability zone of the instance"
  value       = aws_instance.test-ec2.availability_zone
}

output "public_ip" {
  description = "The public IP of the instance"
  value       = aws_instance.test-ec2.public_ip
}

output "private_ip" {
  description = "The private IP of the instance"
  value       = aws_instance.test-ec2.private_ip
}

output "placement_group" {
  description = "The placement group of the instance"
  value       = aws_instance.test-ec2.placement_group
}

output "key_name" {
  description = "The key name of the instance"
  value       = aws_instance.test-ec2.key_name
}

output "password_data" {
  description = "Base-64 encoded password data when using the key"
  value       = aws_instance.test-ec2.password_data
}

output "public_dns" {
  description = "The public DNS name of the instance"
  value       = aws_instance.test-ec2.public_dns
}

