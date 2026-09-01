
# data "aws_ssm_parameter" "database_subnet_ids" {
#   name = "/expense/dev/databse_subnet_ids"
# }
data "aws_ssm_parameter" "database_subnet_group_name" {
  name = "/expense/dev/database_subnet_group_name"
}

data "aws_ssm_parameter" "mysql_sg_id" {
  name = "/expense/dev/mysql_sg_id"
}
data "aws_route53_zone" "expense" {
name = "mxyz.shop" # Fully qualified domain name

}