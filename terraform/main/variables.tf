variable "project" {
    default = "botattempt-1567093478511"
 }

variable "credentials_file" { 
    default = "C:\\Users\\Valery\\AppData\\Local\\Packages\\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\\LocalCache\\Roaming\\gcloud\\application_default_credentials.json"
}

variable "region" {
  type = object(
    {
        region = string
        zone = string
    }
  )
  default = {
    region = "us-central1"
    zone = "us-central1-c"
  }
}

variable "bucket_name" {
    default = "my-small-bucket"
}