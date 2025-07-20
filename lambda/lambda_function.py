import json

def lambda_handler(event, context):
    print("Received event:", event)
    report = {"status": "Report generated successfully"}
    return {
        'statusCode': 200,
        'body': json.dumps(report)
    }

