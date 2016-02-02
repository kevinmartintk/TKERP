json.array! @clients do |client|
  json.id client.id
  json.name client.name
end