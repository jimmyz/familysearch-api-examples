require 'faraday'
require 'json'
require 'pp'

# For sake of demonstration, we will acquire an access token from
# https://sandbox.familysearch.org/platform/
access_token = File.read 'access_token.txt'

client = Faraday.new () do |faraday|
  faraday.response :logger
  faraday.headers['Accept'] = 'application/x-fs-v1+json,application/x-gedcomx-atom+json,application/json'
  faraday.authorization('Bearer',access_token)
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

response = client.get "https://sandbox.familysearch.org/platform/collections/tree"
gedcomx = JSON.parse response.body

current_person_url = gedcomx['collections'][0]['links']['current-user-person']['href']

response = client.get current_person_url

if response.status == 303
  
  response = client.get response.headers['location']
  gedcomx = JSON.parse response.body
  # pp gedcomx

  puts "Name: " + gedcomx['persons'][0]['display']['name']
  puts "Gender: " + gedcomx['persons'][0]['display']['gender']
  puts "Birth Date: " + gedcomx['persons'][0]['display']['birthDate']
end


