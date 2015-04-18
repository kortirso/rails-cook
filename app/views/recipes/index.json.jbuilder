json.array!(@recipes) do |recipe|
	json.extract! recipe, :id, :name, :short, :category_id, :country_id, :photo, :caption, :steps, :user_id, :visible
	json.url recipe_url(recipe, format: :json)
end
