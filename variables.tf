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