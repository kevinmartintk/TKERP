json.array!(@prospects) do |prospect|
  json.extract! prospect, :id
  json.url prospect_url(prospect, format: :json)
end
