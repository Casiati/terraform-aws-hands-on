variable "aws_region" {
  description = "Regiao AWS padrao para os recursos"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente de execucao"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Zonas de disponibilidade para alta disponibilidade"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDRs para subnets publicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDRs para subnets privadas de aplicacao"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidrs" {
  description = "CIDRs para subnets de banco de dados"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway no ambiente dev"
  type        = bool
  default     = true
}

variable "app_port" {
  description = "Porta da aplicacao"
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Porta do banco de dados (PostgreSQL)"
  type        = number
  default     = 5432
}
