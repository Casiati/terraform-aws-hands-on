output "alb_security_group_id" {
  description = "ID do Security Group do Load Balancer"
  value       = aws_security_group.alb.id
}

output "app_security_group_id" {
  description = "ID do Security Group da Aplicacao"
  value       = aws_security_group.app.id
}

output "database_security_group_id" {
  description = "ID do Security Group do Banco de Dados"
  value       = aws_security_group.database.id
}

output "app_iam_role_arn" {
  description = "ARN da IAM Role da aplicacao"
  value       = aws_iam_role.app_role.arn
}

output "app_iam_role_name" {
  description = "Nome da IAM Role da aplicacao"
  value       = aws_iam_role.app_role.name
}

output "app_instance_profile_name" {
  description = "Nome do IAM Instance Profile para inst?ncias EC2/ECS"
  value       = aws_iam_instance_profile.app_profile.name
}
