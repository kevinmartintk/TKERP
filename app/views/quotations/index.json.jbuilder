json.array!(@quotations) do |quotation|
  json.extract! quotation, :id
  json.url quotation_url(quotation, format: :json)
end
