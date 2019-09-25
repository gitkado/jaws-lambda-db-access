require 'json'
require 'aws-sdk'
require 'securerandom'

def dynamodb_client
  @dynamodb_client ||= Aws::DynamoDB::Client.new(
    region: 'ap-northeast-1'
  )
end

def handler(event:, context:)
  dynamodb_client.put_item({
    table_name: 'access_table',
    item: {
      id: SecureRandom.uuid,
      timestamp: Time.now.to_s
    }
  })

  {statusCode: 200, body: JSON.generate('OK')}
end