# Learn Hugo Project

A simple Hugo website built with the PaperMod theme to demonstrate Hugo functionality.

## Getting Started

### Prerequisites

- [Hugo](https://gohugo.io/installation/) (extended version recommended)
- Git

### Running the project

1. Clone this repository
2. Navigate to the project directory
3. Run the development server:
   ```bash
   make server
   ```
4. Visit [http://localhost:1313](http://localhost:1313) in your browser

## Project Structure

- **Theme**: PaperMod
- **Content**:
  - Home page
  - About page
  - Blog posts
  - Projects showcase
  - Contact page
- **Navigation**: Top menu bar with links to all sections

## Making Changes

### Adding Content

- Create new blog posts:
  ```bash
  hugo new posts/your-post-name.md
  ```

- Create new pages:
  ```bash
  hugo new page/your-page-name.md
  ```

### Build for Production

```bash
make build-prod
```

The static site will be generated in the `public/` directory.

## Deployment

This site is configured for deployment to AWS using:
- S3 for static website hosting
- CloudFront CDN for production (optional)
- GitHub Actions for CI/CD

### Infrastructure

The infrastructure is defined using Terraform in the `infra/` directory, using the [CloudPosse S3 Website Module](https://github.com/cloudposse/terraform-aws-s3-website).

The Terraform configuration is environment-agnostic, with environment-specific variables in:
- `infra/environments/dev/terraform.tfvars` - Development environment configuration
- `infra/environments/prod/terraform.tfvars` - Production environment configuration

To deploy the infrastructure:
```bash
cd infra
terraform init \
  -backend-config="bucket=your-terraform-state-bucket" \
  -backend-config="key=dev/terraform.tfstate" \
  -backend-config="region=us-east-1" \
  -backend-config="dynamodb_table=your-terraform-locks-table"

terraform apply -var-file="environments/dev/terraform.tfvars"
```

### GitHub Actions

Automated deployments are handled by GitHub Actions. The workflow:
1. Builds the Hugo site
2. Deploys the Terraform infrastructure
3. Uploads the site to the S3 bucket
4. Invalidates CloudFront cache (for production)

To use this feature, set up the following GitHub repository secrets:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION` (defaults to us-east-1)
- `TF_STATE_BUCKET` (S3 bucket for Terraform state)
- `TF_LOCK_TABLE` (DynamoDB table for Terraform state locking)

You can deploy to different environments by:
1. Pushing to the main branch (defaults to dev)
2. Manually triggering the workflow and selecting the environment

## Makefile Commands

- `make server` - Start the development server with draft content
- `make build` - Build the site including draft content
- `make build-prod` - Build the site for production (no drafts)
- `make clean` - Remove the build directory

## Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [PaperMod Theme](https://github.com/adityatelange/hugo-PaperMod)
- [CloudPosse S3 Website Module](https://github.com/cloudposse/terraform-aws-s3-website) 