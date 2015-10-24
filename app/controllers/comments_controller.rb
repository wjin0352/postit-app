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

  def vote
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @vote = Vote.create(votable: @comment, vote: params[:vote], creator: current_user)
    flash['notice'] = "Vote on comment was recorded"
    redirect_to :back
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end

end
