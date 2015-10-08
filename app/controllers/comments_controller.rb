class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comments_params)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end

end
