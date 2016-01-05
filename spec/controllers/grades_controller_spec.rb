RSpec.describe GradesController, type: :controller do
    describe 'GET #create' do
        let(:mark) { 5 }
        let(:recipe) { create :recipe }

        it 'for guest user, mark not created' do
            expect { xhr :get, :create, mark: mark, recipe_id: recipe.id, format: :js }.to_not change(Grade, :count)
        end
        
        context 'for logged user' do
            sign_in_user
            let(:recipe_with_grade) { create :recipe }
            let(:grade) { create :grade, user: @current_user, recipe: recipe_with_grade }

            it 'if grade exists then render nothing' do
                xhr :get, :create, mark: mark, recipe_id: recipe_with_grade.id, format: :js

                expect(response.body).to be_blank
            end

            it 'else grade creates', format: :js do
                expect { xhr :get, :create, mark: mark, recipe_id: recipe.id, format: :js }.to change(Grade, :count).by(1)
            end
        end
    end
end