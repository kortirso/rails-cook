class CommentsController < ApplicationController
    before_filter :authenticate_user!

    def create
        @comment = Comment.create(comment_params.merge(user: current_user))
        @recipe = @comment.recipe
    end

    private
    def comment_params
        params.require(:comment).permit(:body, :user_id, :recipe_id)
    end
end
