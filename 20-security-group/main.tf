module "bastion_sg" {
  source = "git::https://github.com/Muneer-sk/terraform.git//modules/security_group?ref=main"
  project_name = var.project_name
  environment = var.environment
  component = "bastion"
  vpc_id = local.vpc_id
}

# bastion rules
resource "aws_security_group_rule" "public_to_bastion" {
  description = "Traffic coming from all to bastion"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = module.bastion_sg.id
  
  
}

module "node_sg" {
  source = "git::https://github.com/Muneer-sk/terraform.git//modules/security_group?ref=main"
  project_name = var.project_name
  environment = var.environment
  component = "node-sg"
  vpc_id = local.vpc_id
}
#node group rules
resource "aws_security_group_rule" "ingress_alb_to_node_group" {
  description = "Traffic coming from ingress to node_group"
  type = "ingress"
  from_port = 30000
  to_port = 32767
  protocol = "tcp"
  security_group_id = module.node_sg.id
  source_security_group_id = module.ingress_alb_sg.id
}
resource "aws_security_group_rule" "eks_control_plane_to_node_group" {
  description = "Traffic coming from eks-control-plane to node_group"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1" 
  source_security_group_id = module.eks_control_plane_sg.id
  security_group_id = module.node_sg.id
  
}
resource "aws_security_group_rule" "node_to_node" {
  description = "Traffic coming from node to node"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1" 
  cidr_blocks = [ "10.0.0.0/16" ] # VPC range
  security_group_id =  module.node_sg.id 
}
resource "aws_security_group_rule" "bastion_to_node_group" {
  description = "Traffic coming from bastion to node"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp" 
  source_security_group_id = module.bastion_sg.id
  security_group_id =  module.node_sg.id 
}

module "eks_control_plane_sg" {
  source = "git::https://github.com/Muneer-sk/terraform.git//modules/security_group?ref=main"
  project_name = var.project_name
  environment = var.environment
  component = "eks-control-plane-sg"
  vpc_id = local.vpc_id
}
# eks rules
resource "aws_security_group_rule" "node_group_to_eks_control_plane" {
  description = "Traffic coming from node_group to eks-control-plane"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1" 
  source_security_group_id = module.node_sg.id 
  security_group_id = module.eks_control_plane_sg.id
}
module "ingress_alb_sg" {
  source = "git::https://github.com/Muneer-sk/terraform.git//modules/security_group?ref=main"
  project_name = var.project_name
  environment = var.environment
  component = "eks-ingress-sg"
  vpc_id = local.vpc_id
}
#ingress rules
resource "aws_security_group_rule" "https_to_ingress_alb" {
  description = "Traffic coming from https to ingress_alb"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.ingress_alb_sg.id
}



# module "mysql_sg" {
#   source = "git::https://github.com/Muneer-sk/terraform.git//modules/security_group?ref=main"
#   project_name = var.project_name
#   environment = var.environment
#   component = var.component
#   vpc_id = local.vpc_id
# }

# module "app_alb_sg" {
#   source = "git::https://github.com/Muneer-sk/terraform.git//modules/security_group?ref=main"
#   project_name = var.project_name
#   environment = var.environment
#   component = "app_alb"
#   vpc_id = local.vpc_id
# }

# module "vpn_sg" {
#   source = "git::https://github.com/Muneer-sk/terraform.git//modules/security_group?ref=main"
#   project_name = var.project_name
#   environment = var.environment
#   component = "vpn"
#   vpc_id = local.vpc_id
# }
# module "web_alb_sg" {
#   source = "git::https://github.com/Muneer-sk/terraform.git//modules/security_group?ref=main"
#   project_name = var.project_name
#   environment = var.environment
#   component = "web_alb"
#   vpc_id = local.vpc_id
# }
# resource "aws_security_group_rule" "web_alb_http" {
#   description = "Traffic coming from http to web_alb"
#   type = "ingress"
#   from_port = 80
#   to_port = 80
#   protocol = "tcp"
#   security_group_id = module.web_alb_sg.id
#   cidr_blocks = ["0.0.0.0/0"]
# }
# resource "aws_security_group_rule" "web_alb_https" {
#   description = "Traffic coming from https to web_alb"
#   type = "ingress"
#   from_port = 443
#   to_port = 443
#   protocol = "tcp"
#   security_group_id = module.web_alb_sg.id
#   cidr_blocks = ["0.0.0.0/0"]
# }


# resource "aws_security_group_rule" "mysql_backend" {
#   description = "Traffic coming from backend to mysql"
#   type = "ingress"
#   from_port = 3306
#   to_port = 3306
#   protocol = "tcp"
#   security_group_id = module.mysql_sg.id
#   source_security_group_id = module.backend_sg.id
  
# }
# resource "aws_security_group_rule" "backend_ansible" {
#   description = "Traffic coming from ansible to backend"
#   type = "ingress"
#   from_port = 22
#   to_port = 22
#   protocol = "tcp"
#   security_group_id = module.backend_sg.id
#   source_security_group_id = module.ansible_sg.id
  
# }

# resource "aws_security_group_rule" "mysql_bastion" {
#   description = "Traffic coming from bastion to mysql_on_port_3306"
#   type = "ingress"
#   from_port = 3306
#   to_port = 3306
#   protocol = "tcp"
#   security_group_id = module.mysql_sg.id
#   source_security_group_id = module.bastion_sg.id
  
# }

# resource "aws_security_group_rule" "bastion_public" {
#   description = "Traffic coming from internet to bastion"
#   type = "ingress"
#   from_port = 0
#   to_port = 0
#   protocol = "tcp"
#   security_group_id = module.bastion_sg.id
#   cidr_blocks = ["0.0.0.0/0"]
  
# }

# resource "aws_security_group_rule" "app_alb_bastion" {
#   description = "Traffic coming from bastion to app_alb"
#   type = "ingress"
#   from_port = 8080
#   to_port = 8080
#   protocol = "tcp"
#   security_group_id = module.app_alb_sg.id
#   source_security_group_id = module.bastion_sg.id
  
# }
