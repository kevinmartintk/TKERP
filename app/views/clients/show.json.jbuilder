Jbuilder.encode do
  json.country @client.country.name
  json.address @client.address
  json.legal_id @client.legal_id
  json.corporate_name @client.corporate_name
  json.contacts do
    json.array! @client.contacts do |contact|
      json.id contact.id
      json.name contact.name
    end
  end
end