resource "aws_dynamodb_table" "tickets_table" {
  name             = var.table_name
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "TicketID"

 attribute {
    name = "TicketID"
    type = "S" 
  }

  attribute {
    name = "UserID"
    type = "S" 
  }

  attribute {
    name = "EventID"
    type = "S" 
  }

global_secondary_index {
    name            = "UserID-index"
    hash_key        = "UserID"
    projection_type = "ALL"
    
  }

  global_secondary_index {
    name            = "EventID-index"
    hash_key        = "EventID"
    projection_type = "ALL"
  }
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"

 point_in_time_recovery {
    enabled = true
  }  

 tags = {
    Name        = var.table_name
    Environment = var.environment
    Project     = var.project_name
  }

}