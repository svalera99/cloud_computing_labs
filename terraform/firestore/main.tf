terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
    google-beta = {
      version = "~> 5.32.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project = var.project
}

provider "google-beta" {
  project     = var.project
  region      = var.region.region
  credentials = file(var.credentials_file)
}

resource "google_project_service" "firestore" {
  service = "firestore.googleapis.com"
  project = var.project
}

resource "google_firestore_database" "default" {
  provider = google-beta
  name        = "(default)"
  project     = var.project
  location_id = var.region.region
  type        = "FIRESTORE_NATIVE"
  deletion_policy = "DELETE"
  delete_protection_state = "DELETE_PROTECTION_DISABLED"

  depends_on = [
    google_project_service.firestore
  ]
}

