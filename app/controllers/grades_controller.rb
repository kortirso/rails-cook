class GradesController < ApplicationController
    before_filter :authenticate_user!

    def create
        @grade = Grade.create(mark: params[:mark], recipe_id: params[:recipe_id], user: current_user)
        @recipe = @grade.recipe.refresh(@grade.mark)
    end

    private
    def grades_params
        params.require(:grade).permit(:mark, :user_id, :recipe_id)
    end
end
