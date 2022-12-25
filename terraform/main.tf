module "deploy" {
  source        = "./build/"
  ENV           = var.ENV
  PSQL_USERNAME = var.PSQL_USERNAME
  PSQL_PASSWORD = var.PSQL_PASSWORD
  DOMAIN        = var.ENV == "staging" ? "staging.cloud.berkeli.co.uk" : "cloud.berkeli.co.uk"
}
