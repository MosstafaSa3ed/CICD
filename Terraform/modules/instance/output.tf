output "bastian_instance_ip" {
  description = "The public ip for ssh access"
  value       = aws_instance.bastion.public_ip
}