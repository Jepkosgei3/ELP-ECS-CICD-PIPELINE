output "frontend_service_name" {
  value = aws_ecs_service.frontend_service.name
}

output "frontend_task_definition_arn" {
  value = aws_ecs_task_definition.frontend_task.arn
}

output "frontend_lb_dns_name" {
  value = aws_lb.frontend_lb.dns_name
}

output "backend_service_name" {
  value = aws_ecs_service.backend_service.name
}

output "backend_task_definition_arn" {
  value = aws_ecs_task_definition.backend_task.arn
}

output "db_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "db_username" {
  value = aws_db_instance.default.username
}

output "db_name" {
  value = aws_db_instance.default.db_name
}

output "db_identifier" {
  value = aws_db_instance.default.id
}

output "db_instance_arn" {
  value = aws_db_instance.default.arn
}