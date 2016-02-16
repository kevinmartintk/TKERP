json.array! @clients do |client|
  json.id               client.id
  json.name             client.name
  json.country          client.country
  json.address          client.address
  json.legal_id         client.legal_id
  json.corporate_name   client.corporate_name
end