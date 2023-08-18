terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "gneginskiy-tf-backend"
    region   = "ru-central1"
    key      = "terraform/prod/terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
