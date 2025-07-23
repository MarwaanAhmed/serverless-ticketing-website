variable "function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "handler_name" {
  description = "The handler function for the Lambda."
  type        = string
}

variable "source_directory" {
  description = "The path to the Lambda function's source code directory (src/my_function)."
  type        = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table the Lambda will interact with (for environment variable)."
  type        = string
}

variable "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table the Lambda will interact with."
  type        = string
}

variable "memory_size" {
  description = "The amount of memory in MB your Lambda function has access to."
  type        = number
  default     = 128
}

variable "timeout" {
  description = "The maximum amount of time (in seconds) that the Lambda function can run."
  type        = number
  default     = 30
}

variable "project_name" {
  description = "The name of the overall project."
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., 'dev', 'prod')."
  type        = string
}

variable "aws_region" {
  description = "The AWS region where resources are deployed."
  type        = string
}

variable "account_id" {
  description = "The AWS Account ID."
  type        = string
}