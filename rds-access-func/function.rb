require 'json'
require 'mysql2'
require 'securerandom'

def mysql_client
  @mysql_client ||= Mysql2::Client.new(
    host: ENV['RDS_ARN'],
    username: 'rootuser',
    password: 'rootuser00',
    database: 'access_db',
    port: 3306
  )
end

def handler(event:, context:)
  mysql_client.query(
    "INSERT INTO access_table (id, timestamp) VALUES (\'#{SecureRandom.uuid}\', \'#{Time.now.to_s}\');"
  ).to_a

  {statusCode: 200, body: JSON.generate('OK')}
end