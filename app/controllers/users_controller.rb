class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # binding.pry
    @user = User.new(users_params)
    if @user.save
      session[:user_id] = @user.id # so im logged in after i register.
      flash['notice'] = "User was successfully registered"
      redirect_to root_path
    else
      render 'new'
    end

  end

  def destroy
  end

  def login
  end

  private

    def users_params
      params.require(:user).permit(:username, :password)
    end

end

