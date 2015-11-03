class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :edit, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_admin, only: [:edit, :update]
  before_action :require_post_creator, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by{|i| i.total_votes }.reverse
  end

  def show
    @comment = Comment.new
  end

  def vote
    @vote = Vote.create(votable: @post, vote: params[:vote], creator: current_user)
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash['notice'] = "Vote was recorded!"
        else
          flash['message'] = "You can only vote on a post once."
        end
        redirect_to :back
      end
      format.js
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
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
    @post = Post.find_by(slug: params[:id])
  end

  def require_post_creator
    if (!current_user.admin? || (logged_in? and (current_user != @post.creator)))
      access_denied
    end
  end

end
