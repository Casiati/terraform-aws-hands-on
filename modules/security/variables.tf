variable "environment" {
  description = "Ambiente de execucao (ex: dev, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde os security groups serao criados"
  type        = string
}

variable "app_port" {
  description = "Porta TCP exposta pela aplicacao"
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Porta TCP do banco de dados (ex: 5432 para PostgreSQL)"
  type        = number
  default     = 5432
}
