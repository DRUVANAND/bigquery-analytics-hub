terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.58.0"
    }
  }
  #backend "gcs" {
  #   bucket  = "your-backend-bucket"
  #   prefix  = "bigquery-analytics-hub"
  # }
}

provider "google" {
  project     = "your-project-id"
}

module "bigquery_analytics_hub" {
  source = "./src"
}
