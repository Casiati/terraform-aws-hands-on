output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "Lista de IDs das subnets p?blicas"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Lista de IDs das subnets privadas"
  value       = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  description = "Lista de IDs das subnets de banco de dados"
  value       = aws_subnet.database[*].id
}

output "nat_gateway_id" {
  description = "ID do NAT Gateway (se provisionado)"
  value       = try(aws_nat_gateway.nat[0].id, null)
}
