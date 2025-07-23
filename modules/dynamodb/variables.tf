variable "table_name" {
  description = "The name of the DynamoDB table."
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., 'dev', 'prod')."
  type        = string
}

variable "project_name" {
  description = "The name of the overall project."
  type        = string
}