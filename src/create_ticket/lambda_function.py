import json
import os
import uuid
import datetime
import boto3

dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('TABLE_NAME')


if not table_name:
    raise ValueError("TABLE_NAME environment variable not set.")
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    """
    Handles incoming requests to create a new ticket.
    """
    try:
        # Log that will apprear in cloudwatch for the incoming event for debugging
        print(f"Received event: {json.dumps(event)}")

        # API Gateway Proxy Integration for request body
        body = json.loads(event['body'])

        # Input Validation for security
        event_id = body.get('eventId')
        if not event_id:
            return {
                'statusCode': 400,
                'headers': { 'Content-Type': 'application/json' },
                'body': json.dumps({'message': 'eventId is required in the request body'})
            }

        # Generate unique IDs and timestamps
        ticket_id = str(uuid.uuid4())
        user_id = str(uuid.uuid4())
        status = "CLAIMED"
        created_at = datetime.datetime.now(datetime.timezone.utc).isoformat()

        ticket_item = {
            'TicketID': ticket_id,
            'UserID': user_id,
            'EventID': event_id,
            'Status': status,
            'CreatedAt': created_at
        }

        # Put item into DynamoDB
        table.put_item(Item=ticket_item)

        print(f"Successfully created ticket: {ticket_id}")

        return {
            'statusCode': 201,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({
                'message': 'Ticket created successfully!',
                'ticketId': ticket_id,
                'userId': user_id,
                'eventId': event_id,
                'status': status
            })
        }

    except KeyError as e:
        print(f"Missing key in event body: {e}")
        return {
            'statusCode': 400,
            'headers': { 'Content-Type': 'application/json' },
            'body': json.dumps({'message': f'Invalid request body format: Missing key {e}'})
        }
    except json.JSONDecodeError:
        print("Invalid JSON in request body.")
        return {
            'statusCode': 400,
            'headers': { 'Content-Type': 'application/json' },
            'body': json.dumps({'message': 'Invalid JSON in request body'})
        }
    except Exception as e:
        print(f"Error creating ticket: {e}")
        return {
            'statusCode': 500,
            'headers': { 'Content-Type': 'application/json' },
            'body': json.dumps({'message': f'Internal server error: {str(e)}'})
        }