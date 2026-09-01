resource "aws_ssm_parameter" "app_alb_listerner_arn" {
  type = "String"
  name = "/${var.project_name}/${var.environment}/app_alb_listerner_arn"
  value = aws_alb_listener.http.arn
}