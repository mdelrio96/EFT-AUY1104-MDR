variable "project_name" {
  description = "Nombre del proyecto. Se usa como prefijo de los recursos."
  type        = string
  default     = "eft"
}

variable "environment" {
  description = "Entorno de despliegue (dev, qa, prod)."
  type        = string
  default     = "dev"
}

variable "my_ip" {
  description = "CIDR autorizado para SSH (formato x.x.x.x/32)."
  type        = string
}

variable "bucket_name" {
  description = "Nombre único global del bucket S3."
  type        = string
}
