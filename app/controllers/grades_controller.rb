class GradesController < ApplicationController
	before_filter :authenticate_user!

  def show
  end

  def create
  end

  private
    def grades_params
      params.require(:grade).permit(:grade, :user_id, :recipe_id)
    end
end
