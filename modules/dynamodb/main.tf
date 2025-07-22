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
  attribute {
    name = "Status"
    type = "S"
  }
  attribute {
    name = "CreatedAt"
    type = "S"
  }

}