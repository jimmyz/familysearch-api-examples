require 'faraday'
require 'json'
require 'pp'

def display_person(person)
  puts "Name: " + person['display']['name']
  puts "Gender: " + person['display']['gender']
  puts "Birth Date: " + person['display']['birthDate']
end

# For sake of demonstration, we will acquire an access token from
# https://sandbox.familysearch.org/platform/
access_token = File.read 'access_token.txt'

client = Faraday.new () do |faraday|
  # faraday.response :logger
  faraday.headers['Accept'] = 'application/x-fs-v1+json,application/x-gedcomx-atom+json,application/json'
  faraday.authorization('Bearer',access_token)
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end


response = client.get 'https://sandbox.familysearch.org/platform/collections/tree'
gedcomx = JSON.parse response.body

current_person_url = gedcomx['collections'][0]['links']['current-user-person']['href']

response = client.get current_person_url

if response.status == 303
  current_user_person_url = response.headers['location']
  
  response = client.get current_user_person_url
  gedcomx = JSON.parse response.body
  
  person = gedcomx['persons'][0]
  display_person(person)
  
  response = client.get person['links']['parents']['href']
  
  gedcomx = JSON.parse response.body
  
  # pp gedcomx
  
  child_and_parents = gedcomx['childAndParentsRelationships'][0]
  mother_id = child_and_parents['mother']['resourceId']
  father_id = child_and_parents['father']['resourceId']
  
  mother = gedcomx['persons'].find{ |person| person['id'] == mother_id }
  father = gedcomx['persons'].find{ |person| person['id'] == father_id }
  
  puts ""
  puts "Mother"
  display_person mother
  
  puts ""
  puts "Father"
  display_person father
  
  
end




