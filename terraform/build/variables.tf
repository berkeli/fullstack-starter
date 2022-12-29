variable "ENV" {
  description = "The enviroment to deploy to"
  type        = string
  default     = "staging"
}

variable "PSQL_USERNAME" {
  description = "The username for the PostgreSQL server"
  type        = string
  sensitive   = true
}

variable "PSQL_PASSWORD" {
  description = "The password for the PostgreSQL server"
  type        = string
  sensitive   = true
}

variable "DOMAIN" {
  description = "The domain to use for the DNS records"
  type        = string
  default     = "staging.cloud.berkeli.co.uk"
}

variable "LOCATION" {
  description = "The location to deploy to"
  type        = string
  default     = "euwest"
}
