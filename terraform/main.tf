module "deploy" {
  source        = "./build/"
  ENV           = var.ENV
  PSQL_USERNAME = var.PSQL_USERNAME
  PSQL_PASSWORD = var.PSQL_PASSWORD
}
