output "vpc_id" {
  description = "ID da VPC do ambiente dev"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "IDs das subnets publicas (Load Balancers)"
  value       = module.vpc.public_subnet_ids
}

output "private_subnets" {
  description = "IDs das subnets privadas (Containers / EC2)"
  value       = module.vpc.private_subnet_ids
}

output "database_subnets" {
  description = "IDs das subnets isoladas de banco de dados"
  value       = module.vpc.database_subnet_ids
}

output "alb_security_group_id" {
  description = "Security Group do Load Balancer"
  value       = module.security.alb_security_group_id
}

output "app_security_group_id" {
  description = "Security Group da Aplicacao"
  value       = module.security.app_security_group_id
}

output "database_security_group_id" {
  description = "Security Group do Banco de Dados"
  value       = module.security.database_security_group_id
}

output "app_iam_role_arn" {
  description = "IAM Role da aplicacao com permissoes SSM e CloudWatch"
  value       = module.security.app_iam_role_arn
}
