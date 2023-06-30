terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.58.0"
    }
  }
  #backend "gcs" {
  #   bucket  = "dhruv-bigquery-analytics-hub"
  #   prefix  = "bigquery-analytics-hub"
  # }
}

provider "google" {
  credentials = "C:/UpWork Projects/application_default_credentials.json"
  project     = "pro-signal-386907"
}

module "bigquery_analytics_hub" {
  source = "./src"
}
