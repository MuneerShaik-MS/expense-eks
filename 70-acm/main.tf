resource "aws_acm_certificate" "expense" {
  domain_name = "*.${var.zone_name}"
  validation_method = "DNS"
  tags = {
    "Name" = local.resource_name
  }
}
resource "aws_route53_record" "expense" {
  for_each = {
    for i in aws_acm_certificate.expense.domain_validation_options : i.domain_name => {
      name = i.resource_record_name
      record = i.resource_record_value
      type = i.resource_record_type
    }
  }
  allow_overwrite = true
  name = each.value.name
  records = [each.value.record]
  ttl = 60
  type = each.value.type
  zone_id = var.zone_id
}
resource "aws_acm_certificate_validation" "expense" {
  certificate_arn = aws_acm_certificate.expense.arn
  validation_record_fqdns = [for record in aws_route53_record.expense : record.fqdn]
}