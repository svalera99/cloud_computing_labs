terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project = var.project
}

resource "google_storage_bucket" "bucket" {
 name          = var.bucket_name
 location      = var.region.region

 storage_class = "STANDARD"

 uniform_bucket_level_access = true
}

resource "google_pubsub_topic" "topic_creation" {
  name = "my-topic"

  message_retention_duration = "1200s"
}

resource "google_pubsub_subscription" "subscription_creation" {
  name  = "my-subscription"
  topic = google_pubsub_topic.topic_creation.id

  message_retention_duration = "1200s"
  retain_acked_messages      = true

  ack_deadline_seconds = 20

  expiration_policy {
    ttl = "300000.5s"
  }
  retry_policy {
    minimum_backoff = "10s"
  }

  enable_message_ordering  = false
}

resource "google_storage_bucket_object" "object" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.bucket.name
  source = "../function-source.zip"  # Add path to the zipped function source code
}

resource "google_cloudfunctions2_function" "http-function" {
  name        = "my-hhtp-function"
  location    = var.region.region
  description = "FaaS"

  build_config {
    runtime     = "python310"
    entry_point = "http_entry_point"
    environment_variables = {
      BUILD_CONFIG_TEST = "build_test"
    }
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.object.name
      }
    }
  }

   service_config {
    max_instance_count = 1
    available_memory   = "128Mi"
    timeout_seconds    = 60
    environment_variables = {
      SERVICE_CONFIG_TEST = "config_test"
    }
    ingress_settings               = "ALLOW_INTERNAL_ONLY"
    all_traffic_on_latest_revision = true
  }
}
