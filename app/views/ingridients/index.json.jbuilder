json.array!(@ingridients) do |ingridient|
  json.extract! ingridient, :id, :caption, :name_path, :name
  json.url ingridient_url(ingridient, format: :json)
end
