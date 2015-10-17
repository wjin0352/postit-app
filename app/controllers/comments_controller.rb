class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comments_params)
    @comment.creator = current_user

    if @comment.save
      flash["notice"] = "Comment was successfully created."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end

  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end

end
