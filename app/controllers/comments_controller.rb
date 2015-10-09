class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comments_params)
      if @comment.save
        flash[:message] = "Comment was successfully created."
        redirect_to :posts_path
      else
        flash[:message] = "Comment was not created."
        redirect_to :back
      end

  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end

end
