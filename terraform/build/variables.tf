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
