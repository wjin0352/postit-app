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
    @comment = Comment.find(params[:id])
    @vote = Vote.create(votable: @comment, vote: params[:vote], creator: current_user)

    respond_to do |format|
      format.html {
        if @vote.valid?
          flash['notice'] = "Vote on comment was recorded"
        else
          flash['message'] = "You can only vote once on a comment."
        end
        redirect_to :back
      }
      format.js
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end

end
