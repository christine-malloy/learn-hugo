variable "hostname" {
  description = "The hostname to use for the website"
  type        = string
  default     = ""
}

variable "parent_zone_name" {
  description = "The Route53 parent zone name (if using Route53)"
  type        = string
  default     = ""
}

variable "versioning_enabled" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "index_document" {
  description = "S3 Index document"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "S3 Error document"
  type        = string
  default     = "404.html"
}

variable "cors_allowed_headers" {
  description = "List of allowed headers"
  type        = list(string)
  default     = ["*"]
}

variable "cors_allowed_methods" {
  description = "List of allowed methods (e.g. GET, PUT, POST, DELETE, HEAD)"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cors_allowed_origins" {
  description = "List of allowed origins (e.g. example.com, test.com)"
  type        = list(string)
  default     = ["*"]
}

variable "cors_max_age_seconds" {
  description = "Time in seconds that browser can cache the response"
  type        = number
  default     = 3600
}

variable "logs_expiration_days" {
  description = "Number of days after which to expunge the objects"
  type        = number
  default     = 90
}

variable "logs_standard_transition_days" {
  description = "Number of days to persist in the standard storage tier before moving to the glacier tier"
  type        = number
  default     = 30
}

variable "logs_glacier_transition_days" {
  description = "Number of days after which to move the data to the glacier storage tier"
  type        = number
  default     = 60
}

variable "deployer_username" {
  description = "The username of the deployer"
  type        = string
}
