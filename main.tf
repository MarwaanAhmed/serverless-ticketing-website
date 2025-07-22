module "dynamodb" {
  source          = "./modules/dynamodb"
  table_name      = var.table_name
  project_name    = var.project_name
}