module "vpc" {
  source = "git::https://github.com/mdelrio96/EFT-Modulos-AUY1104-MDR.git//modules/vpc?ref=v1.0.0"

  project_name     = var.project_name
  environment      = var.environment
  allowed_ssh_cidr = var.my_ip
}

module "ec2" {
  source = "git::https://github.com/mdelrio96/EFT-Modulos-AUY1104-MDR.git//modules/ec2?ref=v1.0.0"

  project_name       = var.project_name
  environment        = var.environment
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.vpc.ssh_security_group_id]
}

module "s3" {
  source = "git::https://github.com/mdelrio96/EFT-Modulos-AUY1104-MDR.git//modules/s3?ref=v1.0.0"

  bucket_name = var.bucket_name
  environment = var.environment
}
