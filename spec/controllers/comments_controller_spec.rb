RSpec.describe CommentsController, type: :controller do
    describe 'POST #create' do
        let!(:recipe) { create :recipe }

        it 'for guest user, it doesnt saved in DB' do
            expect { post :create, comment: attributes_for(:comment, :invalid, recipe_id: recipe.id), format: :js }.to_not change(Comment, :count)
        end
        
        context 'for logged user' do
            sign_in_user

            context 'when valid comment' do
                it 'it saves in DB and belongs to recipe' do
                    expect { post :create, comment: attributes_for(:comment, recipe_id: recipe.id), format: :js }.to change(recipe.comments, :count).by(1)
                end

                it 'and belongs to current_user' do
                    expect { post :create, comment: attributes_for(:comment, recipe_id: recipe.id), format: :js }.to change(@current_user.comments, :count).by(1)
                end
            end

            context 'when invalid comment' do
                it 'it doesnt saved in DB' do
                    expect { post :create, comment: attributes_for(:comment, :invalid, recipe_id: recipe.id), format: :js }.to_not change(Comment, :count)
                end
            end
        end
    end
end