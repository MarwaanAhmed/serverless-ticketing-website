#DynamoDB

variable "table_name" {
    description = "The name of the DynamoDB table."
    type        = string
    default     = "serverless-ticketing-tickets"
  
}

variable "project_name" {
  description = "The name of the serverless ticketing project."
  type        = string
  default     = "serverless-ticketing"
}

#LAMBDA 

variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "eu-west-2"
}

variable "account_id" {
  description = "The AWS Account ID where resources are deployed."
  type        = string
  default     = "137068238934"
}

variable "environment" {
  description = "The deployment environment (e.g., 'dev', 'prod')."
  type        = string
  default     = "dev"
}