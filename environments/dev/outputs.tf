output "vpc_id" {
  description = "ID da VPC do ambiente dev"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "IDs das subnets p?blicas (Load Balancers)"
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
