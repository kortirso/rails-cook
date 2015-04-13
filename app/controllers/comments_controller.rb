class CommentsController < ApplicationController
	def new
		@comment = Comment.new
	end

	def create
  	@comment = Comment.new(comment_params)

  	respond_to do |format|
  		if @comment.save
        @rec = @comment.recipe
        format.html { render :comments }
        format.js
  			format.json { render :show, status: :created, location: @comment }
  		else
  			format.html { render :new }
  			format.json { render json: @comment.errors, status: :unprocessable_entity }
  		end
  	end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :user_id, :recipe_id)
    end
end
