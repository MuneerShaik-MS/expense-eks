data "aws_ssm_parameter" "vpc_id" {
  name = "/expense/dev/vpc_id"
}
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/expense/dev/private_subnet_ids"
}
data "aws_ssm_parameter" "eks_control_plane_sg" {
    name = "/expense/dev/eks_control_plane_sg"
}
data "aws_ssm_parameter" "node_sg_id" {
  name = "/expense/dev/node_sg_id"
}