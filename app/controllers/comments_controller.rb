class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = User.first

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
