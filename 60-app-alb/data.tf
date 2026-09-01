data "aws_ssm_parameter" "vpc_id" {
    name = "/expense/dev/vpc_id"
}
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/expense/dev/private_subnet_ids"
}
data "aws_ssm_parameter" "app_alb_sg_id" {
  name = "/expense/dev/app_alb_sg_id"
}