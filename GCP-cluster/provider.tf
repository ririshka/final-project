terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

terraform {
  backend "gcs" {
    bucket = "my-bucket-aiperi"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "inner-nuance-332319"
  region  = "us-central1"
}