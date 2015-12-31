class CommentsController < ApplicationController
    before_filter :authenticate_user!

    def create
        @comment = Comment.new(comment_params.merge(user_id: current_user.id))
        respond_to do |format|
            if @comment.save
                @recipe = @comment.recipe
                format.html { render :comments }
                format.js
            else
                format.html { render :new }
            end
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:body, :user_id, :recipe_id)
    end
end
