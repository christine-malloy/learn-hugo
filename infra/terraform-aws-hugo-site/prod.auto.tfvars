name        = "learn-hugo"

# https://docs.aws.amazon.com/amplify/latest/userguide/getting-started.html
# The GitHub PAT needs to have the scope `admin:repo_hook`
# Refer to "Setting up the Amplify GitHub App for AWS CloudFormation, CLI, and SDK deployments"
# in https://docs.aws.amazon.com/amplify/latest/userguide/setting-up-GitHub-access.html
github_personal_access_token_secret_path = "/gm-amplify-app-learn-hugo/github-token"

platform = "WEB"

repository = "https://github.com/christine-malloy/learn-hugo"

iam_service_role_enabled = true

# https://docs.aws.amazon.com/amplify/latest/userguide/ssr-CloudWatch-logs.html
iam_service_role_actions = [
  "logs:CreateLogStream",
  "logs:CreateLogGroup",
  "logs:DescribeLogGroups",
  "logs:PutLogEvents"
]

enable_auto_branch_creation = true

enable_branch_auto_build = true

enable_branch_auto_deletion = true

enable_basic_auth = false

auto_branch_creation_patterns = [
  "*",
  "*/**"
]

auto_branch_creation_config = {
  # Enable auto build for the created branches
  enable_auto_build = true
}

# Fill out build_spec
build_spec = <<-EOT
  EOT

custom_rules = [
  {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }
]

# Custom header, HTST to always block HTTP and always redirect to HTTPS
custom_headers = <<-EOT
  customHeaders:
    - pattern: '**'
      headers:
        - key: 'Strict-Transport-Security'
          value: 'max-age=31536000; includeSubDomains'
EOT

environment_variables = {
  ENV = "prod"
}

environments = {
  main = {
    branch_name                 = "main"
    enable_auto_build           = true
    backend_enabled             = false
    enable_performance_mode     = true
    enable_pull_request_preview = false
    framework                   = "Hugo"
    stage                       = "PRODUCTION"
  }
}

domains = null
