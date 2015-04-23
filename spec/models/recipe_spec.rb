describe Recipe do

	it "validates the name and makes sure it's not empty" do
		recipe = Recipe.new(name: '')
		recipe.valid?
		recipe.errors[:name].should_not be_empty
	end

end