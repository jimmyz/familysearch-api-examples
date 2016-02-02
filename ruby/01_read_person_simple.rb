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

response = client.get "https://sandbox.familysearch.org/platform/tree/persons/KW4V-6T7"
gedcomx = JSON.parse response.body
pp gedcomx
puts "Name: " + gedcomx['persons'][0]['display']['name']
puts "Gender: " + gedcomx['persons'][0]['display']['gender']
puts "Birth Date: " + gedcomx['persons'][0]['display']['birthDate']