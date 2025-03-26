locals {
  domain = {
    hostname = "${module.this.id}-${random_string.signifier.result}"
  }

  website = {
    versioning_enabled = true
    index_document     = "index.html"
    error_document     = "error.html"
  }

  cors = {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = 3600
  }

  logs = {
    expiration_days          = var.logs_expiration_days
    standard_transition_days = var.logs_standard_transition_days
    glacier_transition_days  = var.logs_glacier_transition_days
  }

  force_destroy = true
}

resource "random_string" "signifier" {
  length  = 5
  special = false
  upper   = false
}

module "s3_website" {
  source  = "cloudposse/s3-website/aws"
  version = "0.18.0"

  name      = module.this.name
  stage     = module.this.stage
  namespace = module.this.namespace

  hostname           = local.domain.hostname
  versioning_enabled = local.website.versioning_enabled
  index_document     = local.website.index_document
  error_document     = local.website.error_document

  cors_allowed_headers = local.cors.allowed_headers
  cors_allowed_methods = local.cors.allowed_methods
  cors_allowed_origins = local.cors.allowed_origins
  cors_max_age_seconds = local.cors.max_age_seconds

  logs_expiration_days          = local.logs.expiration_days
  logs_standard_transition_days = local.logs.standard_transition_days
  logs_glacier_transition_days  = local.logs.glacier_transition_days

  deployment_arns = {
    (data.aws_iam_user.deployer.arn) = ["/*"]
  }

  force_destroy = local.force_destroy

  tags = module.this.tags
}

output "context_id" {
  value = module.this.id
}

output "context_name" {
  value = module.this.name
}