# terragrunt.hcl

locals {
  # Automatically load common.yaml variables
  common_vars = yamldecode(file("common.yaml"))
}

# 1. GENERATE REMOTE STATE (Backend)
# This automatically creates a backend.tf in every app folder
remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    project = "my-seed-project-id" # The project hosting the bucket
    bucket  = local.common_vars.tf_state_bucket
    prefix  = "${path_relative_to_include()}/terraform.tfstate"
    location = local.common_vars.region
  }
}

# 2. GENERATE PROVIDER
# This automatically creates a provider.tf in every app folder
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  project = "${local.common_vars.billing_account}" # Temp placeholder, overridden by module
  region  = "${local.common_vars.region}"
}
EOF
}

# 3. GLOBAL INPUTS
# Pass the variables from common.yaml to all child modules automatically
inputs = merge(
  local.common_vars,
  {
    # Add any calculated global inputs here if needed
  }
)