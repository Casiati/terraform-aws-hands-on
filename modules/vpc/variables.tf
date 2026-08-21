variable "vpc_cidr" {
  description = "Bloco CIDR para a VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Ambiente de execu??o (ex: dev, prod)"
  type        = string
}

variable "availability_zones" {
  description = "Lista de Zonas de Disponibilidade (AZs) para alta disponibilidade"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "Blocos CIDR para subnets p?blicas (ex: Load Balancers)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Blocos CIDR para subnets privadas (ex: Aplica??es / Containers)"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidrs" {
  description = "Blocos CIDR para subnets isoladas de banco de dados (ex: RDS)"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "enable_nat_gateway" {
  description = "Se verdadeiro, provisiona NAT Gateway para sa?da de internet das subnets privadas"
  type        = bool
  default     = true
}
