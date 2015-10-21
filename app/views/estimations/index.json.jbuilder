json.array!(@estimations) do |estimation|
  json.extract! estimation, :id
  json.url estimation_url(estimation, format: :json)
end
