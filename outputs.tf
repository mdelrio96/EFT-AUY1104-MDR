output "vpc_id" {
  description = "ID de la VPC creada por el módulo vpc."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas creadas por el módulo vpc."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas creadas por el módulo vpc."
  value       = module.vpc.private_subnet_ids
}

output "ssh_security_group_id" {
  description = "ID del Security Group SSH creado por el módulo vpc."
  value       = module.vpc.ssh_security_group_id
}

output "instance_id" {
  description = "ID de la instancia EC2 creada por el módulo ec2."
  value       = module.ec2.instance_id
}

output "instance_ip" {
  description = "IP pública de la instancia EC2."
  value       = module.ec2.instance_ip
}

output "bucket_name" {
  description = "Nombre del bucket S3 creado por el módulo s3."
  value       = module.s3.bucket_name
}
