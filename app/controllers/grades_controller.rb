class GradesController < ApplicationController
  def create
  	@grade = Grade.new(mark: params[:mark], user_id: params[:user_id], recipe_id: params[:recipe_id])

  	respond_to do |format|
  		if @grade.save
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
