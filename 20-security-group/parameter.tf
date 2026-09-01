resource "aws_ssm_parameter" "ingress_alb_sg_id" {
    type = "String"
  name = "/${var.project_name}/${var.environment}/app_alb_sg_id"
  value = module.ingress_alb_sg.id
}
resource "aws_ssm_parameter" "bastion_sg_id" {
    type = "String"
  name = "/${var.project_name}/${var.environment}/bastion_sg_id"
  value = module.bastion_sg.id
}

resource "aws_ssm_parameter" "eks_control_plane_sg_id" {
    type = "String"
  name = "/${var.project_name}/${var.environment}/eks_control_plane_sg"
  value = module.eks_control_plane_sg.id
}

resource "aws_ssm_parameter" "node_sg_id" {
    type = "String"
  name = "/${var.project_name}/${var.environment}/node_sg_id"
  value = module.node_sg.id
}

# resource "aws_ssm_parameter" "frontend_sg_id" {
#     type = "String"
#   name = "/${var.project_name}/${var.environment}/frontend_sg_id"
#   value = module.frontend_sg.id
# }
# resource "aws_ssm_parameter" "bastion_sg_id" {
#     type = "String"
#   name = "/${var.project_name}/${var.environment}/bastion_sg_id"
#   value = module.bastion_sg.id
# }
# resource "aws_ssm_parameter" "ansible_sg_id" {
#     type = "String"
#   name = "/${var.project_name}/${var.environment}/ansible_sg_id"
#   value = module.ansible_sg.id
# }

# resource "aws_ssm_parameter" "vpn_sg_id" {
#     type = "String"
#   name = "/${var.project_name}/${var.environment}/vpn_sg_id"
#   value = module.vpn_sg.id
# }
# resource "aws_ssm_parameter" "public_sg_id" {
#     type = "String"
#   name = "/${var.project_name}/${var.environment}/public_sg_id"
#   value = module.public_sg.id
# }
