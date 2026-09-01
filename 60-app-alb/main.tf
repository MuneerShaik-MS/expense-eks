module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = local.resource_name
  vpc_id  = local.vpc_id
  subnets = local.private_subnet_ids
  internal = true
    security_groups = [local.app_alb_sg_id]
create_security_group = false
enable_deletion_protection = false



  tags = {
    Environment = "dev"
    Project     = "expense"
    Component = "app_alb"
  }
}
resource "aws_alb_listener" "http" {
  load_balancer_arn = module.alb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/html"
      message_body = "<h1> Hello, I am from application alb </h1>"
      status_code = "200"
    }
  }
}
resource "aws_route53_record" "alb" {
  zone_id = "Z03689722XQ7TABGNN9KB"
  name    = "*.app-dev.mxyz.shop"
  type    = "CNAME"
  ttl     = 300
  records = [module.alb.dns_name]
  allow_overwrite = true
}