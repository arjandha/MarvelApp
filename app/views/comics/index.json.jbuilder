json.array!(@comics) do |comic|
  json.extract! comic, :id
  json.url comic_url(comic, format: :json)
end
