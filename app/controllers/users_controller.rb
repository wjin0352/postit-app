class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @posts = @user.posts.sort_by{|i| i.total_votes }.reverse
    @comments = @user.comments
  end

  def create
    @user = User.new(users_params)
    if @user.save
      session[:user_id] = @user.id # so im logged in after i register.
      flash['notice'] = "User was successfully registered"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(users_params)
      flash['notice'] = "You have successfully updated your profile"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def users_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash['message'] = "Ah ah ah you didn't say the magic word..."
      redirect_to root_path
    end
  end

end

