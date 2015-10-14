class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :edit]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    # binding.pry
    @post = Post.new(post_params)
    @post.creator = User.first
    # @category = Category.find(params.values[3][:category_id])
    # @post.categories << @category
    if @post.save
      flash["notice"] = 'Your post was successfully created'
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    # binding.pry
    # @category = Category.find(params.values[4][:category_id])
    # @post.categories << @category

    if @post.update_attributes(post_params)
      flash["notice"] = "Your post has been updated."
      redirect_to posts_path
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
