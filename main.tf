data "aws_caller_identity" "current" {}

module "dynamodb" {
  source          = "./modules/dynamodb"
  table_name      = var.table_name
  project_name    = var.project_name
  environment         = var.environment
}

module "create_ticket_lambda" {
  source              = "./modules/lambda_functions"
  function_name       = format("%s-create-ticket-%s", var.project_name, var.environment)
  handler_name        = "lambda_function.lambda_handler"
  source_directory    = "src/create_ticket"
  dynamodb_table_name = module.dynamodb.table_name
  dynamodb_table_arn  = module.dynamodb.table_arn
  aws_region          = var.aws_region
  account_id          = data.aws_caller_identity.current.account_id
  environment         = var.environment
  project_name        = var.project_name
}