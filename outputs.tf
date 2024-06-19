output "instance_public_ip" {
  description = "Ip publico da da instancia"
  value       = aws_instance.example.public_ip
}

output "db_url" {
  description = "URL para acessar o banco de dados"
  value       = "postgresql://${var.database_user}:${var.database_password}@${aws_db_instance.default.endpoint}/${var.database_name}"
}