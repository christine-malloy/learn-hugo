output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3_website.s3_bucket_name
}

output "s3_bucket_domain_name" {
  description = "The domain name of the S3 bucket"
  value       = module.s3_website.s3_bucket_domain_name
}

output "s3_bucket_website_endpoint" {
  description = "The website endpoint URL"
  value       = module.s3_website.s3_bucket_website_endpoint
}

output "s3_bucket_website_domain" {
  description = "The domain of the website endpoint"
  value       = module.s3_website.s3_bucket_website_domain
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3_website.s3_bucket_arn
}

output "s3_bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for this bucket's region"
  value       = module.s3_website.s3_bucket_hosted_zone_id
}

output "hostname" {
  description = "Bucket hostname"
  value       = module.s3_website.hostname
} 