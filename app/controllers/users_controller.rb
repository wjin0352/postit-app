class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  # before_action :set_time_zone, except: [:show]

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
      if @user.two_factor_auth?
        session[:two_factor] = true
        @user.create_pin!
        session[:user_id] = @user.id # so im logged in after i register.
        redirect_to pin_path
      elsif
        session[:user_id] = @user.id # so im logged in after i register.
        flash['notice'] = "User was successfully registered"
        redirect_to root_path
    else
      render 'new'
    end
  end
  end

  def edit
  end

  def update
    if @user.update(users_params)
      if @user.two_factor_auth?
        session[:two_factor] = true
        @user.create_pin!
        redirect_to pin_path
      elsif
        flash['notice'] = "You have successfully updated your profile"
        redirect_to user_path(@user)
    else
      render :edit
      end
    end
  end

  private

  def users_params
    params.require(:user).permit(:username, :password, :time_zone, :phone, :pin)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def require_same_user
    if current_user != @user
      flash['message'] = "Ah ah ah you didn't say the magic word..."
      redirect_to root_path
    end
  end

  # def set_time_zone
  #   tz = current_user ? current_user.time_zone : nil
  #   Time.zone =  tz || ActiveSupport::TimeZone["Eastern Time (US & Canada)"]
  # end

end

