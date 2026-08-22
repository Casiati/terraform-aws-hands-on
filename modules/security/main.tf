# Security Group do Load Balancer (ALB): entrada p?blica para HTTP/HTTPS
resource "aws_security_group" "alb" {
  name_prefix = "sg-${var.environment}-alb-"
  description = "Controle de trafego publico para o Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP publico"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS publico"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg-${var.environment}-alb"
    Tier = "Public"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Security Group da Aplicacao: aceita conexoes apenas originadas do Security Group do ALB
resource "aws_security_group" "app" {
  name_prefix = "sg-${var.environment}-app-"
  description = "Acesso restrito a aplicacao recebendo trafego apenas do ALB"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Trafego da aplicacao vindo exclusivamente do ALB"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg-${var.environment}-app"
    Tier = "Private"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Security Group do Banco: aceita conexao apenas originada do Security Group da Aplicacao
resource "aws_security_group" "database" {
  name_prefix = "sg-${var.environment}-db-"
  description = "Acesso restrito ao banco de dados recebendo trafego apenas da camada de aplicacao"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Acesso ao banco restrito ao SG da aplicacao"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  # Sem regra de egress aberta para a internet; mantem comunicacao controlada
  tags = {
    Name = "sg-${var.environment}-db"
    Tier = "Database"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# IAM Role para instancias / containers da aplicacao
resource "aws_iam_role" "app_role" {
  name_prefix = "role-${var.environment}-app-"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = [
            "ec2.amazonaws.com",
            "ecs-tasks.amazonaws.com"
          ]
        }
      }
    ]
  })

  tags = {
    Name = "role-${var.environment}-app"
  }
}

# Permite conexao via AWS Systems Manager (SSM) eliminando necessidade de chave SSH e porta 22 aberta
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.app_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Permite envio de logs e metricas para o CloudWatch
resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.app_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "app_profile" {
  name_prefix = "instance-profile-${var.environment}-app-"
  role        = aws_iam_role.app_role.name
}
