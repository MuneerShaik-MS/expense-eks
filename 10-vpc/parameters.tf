resource "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
  value = module.vpc.vpc_id
  type = "String"
}
resource "aws_ssm_parameter" "public_subnet_ids" {
  type = "StringList"
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
  value = join(",",module.vpc.public_subnet_ids)
}
resource "aws_ssm_parameter" "private_subnet_ids" {
  type = "StringList"
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
  value = join(",",module.vpc.private_subnet_ids)
}
resource "aws_ssm_parameter" "database_subnet_ids" {
  type = "StringList"
  name = "/${var.project_name}/${var.environment}/database_subnet_ids"
  value = join(",",module.vpc.database_subnet_ids)
}
resource "aws_ssm_parameter" "database_subnet_group_name" {
  type = "StringList"
  name = "/${var.project_name}/${var.environment}/database_subnet_group_name"
  value = module.vpc.database_subnet_group_name
}