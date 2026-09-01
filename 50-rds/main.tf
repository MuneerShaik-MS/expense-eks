module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.resource_name

  engine            = "mysql"
  engine_version    = "8.0.46"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "transactions"
  username = "root"
  port     = "3306"
  password_wo = "ExpenseApp1"
  manage_master_user_password = true


  vpc_security_group_ids = [local.mysql_sg_id]

db_subnet_group_name = local.database_subnet_group_name

 
  tags = {
    Project = "expense"
    environment = "dev"
  }

skip_final_snapshot = true
  

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"


  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}

resource "aws_route53_record" "mysql_record" {
  zone_id = data.aws_route53_zone.expense.id
  name    = "mysql-${var.environment}.${data.aws_route53_zone.expense.name}"
  type    = "CNAME"
  ttl     = 1
  records = [module.db.db_instance_address]
  allow_overwrite = true
}