output "instance_ip_addr" {
  value       = aws_instance.simple_ec2.private_ip
  description = "IP privado da instancia"
}

output "instance_public_addr" {
  value       = aws_instance.simple_ec2.public_ip
  description = "IP Publico da instancia"

}