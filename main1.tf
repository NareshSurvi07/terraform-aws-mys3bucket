module "TakedaIAMRole" {
  source                 = "app.terraform.io/Takeda/IAMRole/aws"
  version                = "v0.0.6"
  shared_tags            = var.shared_tags
  use_trust_policy_file  = false
  use_inline_policy_file = false
  inline_policy_json     = local.inline_pol
  trust_policy_json      = local.trust_pol
  trust_policy           = var.trust_policy_file
  assuming_resource      = var.assuming_resource
  purpose                = var.purpose
}

data "aws_caller_identity" "current_caller_identity" {}

locals {
  trust_pol  = templatefile("${path.cwd}/${var.trust_policy_file}", { external_role_arn = var.external_role_arn })
  inline_pol = templatefile("${path.cwd}/${var.policy_file}", { bucket_name = var.bucket_name, bucket_name_destination_vendor_p2 = var.bucket_name_destination_vendor_p2, prefix = var.prefix, prefix_eps = var.prefix_eps, prefix_inbound = var.prefix_inbound, prefix_outbound = var.prefix_outbound, edb_s3_kms_arn = var.edb_s3_kms_arn, bucket_name_destination_vendor = var.bucket_name_destination_vendor })
}
