json.array!(@measures) do |measure|
    json.extract! measure, :id
    json.url measure_url(measure, format: :json)
end
