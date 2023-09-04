# Create BigQuery Analytics Hub Data Exchange
resource "google_bigquery_analytics_hub_data_exchange" "data_exchange" {
  location         = var.region
  data_exchange_id = var.data_exchange_id
  display_name     = "product_vendor"
  description      = "data exchange"
}

# Create google_bigquery_analytics_hub_data_exchange_iam_policy
data "google_iam_policy" "admin" {
  binding {
    role    = "roles/viewer"
    members = [
  "serviceAccount:123abc-compute@developer.gserviceaccount.com",
]

  }
}

resource "google_bigquery_analytics_hub_data_exchange_iam_policy" "policy" {
  project          = google_bigquery_analytics_hub_data_exchange.data_exchange.project
  location         = google_bigquery_analytics_hub_data_exchange.data_exchange.location
  data_exchange_id = google_bigquery_analytics_hub_data_exchange.data_exchange.data_exchange_id
  policy_data      = data.google_iam_policy.admin.policy_data
}

# Create BigQuery Analytics Hub Listing
resource "google_bigquery_analytics_hub_data_exchange" "listing" {
  location         = var.region
  data_exchange_id = "data_exchange"
  display_name     = "my_data_exchange"
  description      = "example data exchange"
}

resource "google_bigquery_analytics_hub_listing" "listing" {
  project = var.project
  location         = var.region
  data_exchange_id = google_bigquery_analytics_hub_data_exchange.data_exchange.data_exchange_id
  listing_id       = var.listing_id
  display_name     = "my_listing_data"
  description      = "data exchange"

  bigquery_dataset {
    dataset = google_bigquery_dataset.listing.dataset_id
  }

   # Add publisher and request access
  publisher {
    name = "publisher"
    primary_contact = "123abc-compute@developer.gserviceaccount.com"
  }

  request_access = "456xyz-compute@developer.gserviceaccount.com"
}

resource "google_bigquery_dataset" "listing" {
  dataset_id      = "product_vendor_data_123"
  friendly_name   = "product_vendor_data"
  description     = "my dataset"
  location        = var.region
}

# Create google_bigquery_analytics_hub_listing_iam_policy
resource "google_bigquery_analytics_hub_listing_iam_policy" "policy" {
  project          = google_bigquery_analytics_hub_listing.listing.project
  location         = google_bigquery_analytics_hub_listing.listing.location
  data_exchange_id = google_bigquery_analytics_hub_listing.listing.data_exchange_id
  listing_id       = google_bigquery_analytics_hub_listing.listing.listing_id
  policy_data      = data.google_iam_policy.admin.policy_data
}
