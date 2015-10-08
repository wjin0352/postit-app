class PostsController < ApplicationController


  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      respond_to do |format|
        format.html {
          flash.now('Your post was successfully created')
          redirect_to :posts_path
        }
      end
    else
      render :new
    end
  end

  def edit

  end

  def update

  end


  private

  # for mass assignment
  def post_params
    params.require(:post).permit(:title, :url, :description)
  end


end
