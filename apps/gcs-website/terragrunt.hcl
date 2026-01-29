# applications/ecom-backend/terragrunt.hcl
locals {
  # Automatically load common.yaml variables
  common_vars = yamldecode(file(find_in_parent_folders("common.yaml")))
}

# Include the root configuration (backend, provider, globals)
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Source the Project Factory Module
terraform {
  source = "https://github.com/bodnarmarian14/gcp-tf-modules/gcs"
}

inputs = {
  name       = "my-awesome-static-site-dev"
  location   = "EU"
  project_id = local.common_vars.project_id

  # Website Configuration
  enable_website   = true
  main_page_suffix = "index.html"
  not_found_page   = "404.html"

  # Upload Objects (Using the 'assets' folder next to this file)
  bucket_objects = {
    "index" = {
      name         = "index.html"
      content_type = "text/html"

      source = "${get_terragrunt_dir()}/assets/index.html"
    }
    "error" = {
      name         = "404.html"
      content_type = "text/html"
      source       = "${get_terragrunt_dir()}/assets/404.html"
    }
    "style" = {
      name         = "style.css"
      content_type = "text/css"
      source       = "${get_terragrunt_dir()}/assets/style.css"
    }
  }

  # Make it public (REQUIRED for static sites)
  iam_rule = {
    "public_viewer" = {
      role   = "roles/storage.objectViewer"
      member = "allUsers"
    }
  }

  # Clean up bucket when destroying via Terraform
  force_destroy = true
}
