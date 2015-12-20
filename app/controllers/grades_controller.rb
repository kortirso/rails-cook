class GradesController < ApplicationController
    before_filter :authenticate_user!

    def create
        @grade = Grade.new(mark: params[:mark], recipe_id: params[:recipe_id])
        @grade.user_id = current_user.id

        respond_to do |format|
            if @grade.save
                @recipe = Recipe.find(@grade.recipe_id)
                stars = @recipe.stars + @grade.mark
                marks = @recipe.marks + 1
                count = stars.to_f / marks
                average = count.round 2
                @recipe.update_attribute('stars', stars)
                @recipe.update_attribute('marks', marks)
                @recipe.update_attribute('average', average)
                format.html { render :grades }
                format.js
                format.json { render :show, status: :created, location: @grade }
            else
                format.html { render :new }
                format.json { render json: @grade.errors, status: :unprocessable_entity }
            end
        end
    end

    private
        def grades_params
            params.require(:grade).permit(:mark, :user_id, :recipe_id)
        end
end
