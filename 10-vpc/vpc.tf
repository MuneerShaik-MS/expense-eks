module "vpc" {
  source = "git::https://github.com/Muneer-sk/terraform.git//modules/vpc?ref=main"
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  project_name = "expense"
}