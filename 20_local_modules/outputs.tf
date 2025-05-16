output "ec2_instance_id" {
  value       = module.webserver.id
  description = "The private IPaddress of the main server instance"
}
