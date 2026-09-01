data "aws_ami" "joindevops"{
    most_recent = true
    owners = ["973714476881"]

}

# data "aws_ssm_parameter" "vpc_id" {
#   name = "/expense/dev/vpc_id"
# }
data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/expense/dev/bastion_sg_id"
}
data "aws_ssm_parameter" "public_subnet_ids"{
    name = "/expense/dev/public_subnet_ids"
}

# data "aws_security_group" "Name" {
#   name = "Inbund"
#   vpc_id = "vpc-0ccf6b8d4be76d9c9"
# }
# # data "aws_key_pair" "linux-key" {
# #   key_name = "linux-key"
# # }