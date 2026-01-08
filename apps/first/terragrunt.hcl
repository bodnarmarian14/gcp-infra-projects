# applications/ecom-backend/terragrunt.hcl

# Include the root configuration (backend, provider, globals)
include "root" {
  path = find_in_parent_folders()
}

# Source the Project Factory Module
terraform {
  source = "tfr:///terraform-google-modules/project-factory/google?version=14.4.0"
}

# Define App-Specific Inputs
# (Billing account and Org ID are inherited automatically from root inputs!)
inputs = {
  name       = "ecom-backend-prod"
  project_id = "ecom-backend-prod-x9z" # Optional: specify or let it auto-generate
  
  # Which APIs does this app need?
  activate_apis = [
    "compute.googleapis.com",
    "sqladmin.googleapis.com",
    "container.googleapis.com"
  ]

  # Labels specific to this app
  labels = {
    env  = "prod"
    team = "backend"
  }
}