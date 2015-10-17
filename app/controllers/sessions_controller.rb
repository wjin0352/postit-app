class SessionsController < ApplicationController

  def new

  end

  def create

    # user.authenticate = "password"
    # 1. get user object (so how do we get the user obj? use binding.pry to see )
    # 2. see if password matches (use authenticate method)
    # 3. if so, login
    # 4. if not, then error message
    # binding.pry
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash['notice'] = "You've successfully logged in"
      redirect_to root_path
    else
      flash[:error] = "Something wrong with username or password"
      render :new
    end


  end

  def destroy
    session[:user_id] = nil
    flash['notice'] = "You're logged out"
    redirect_to root_path
  end

end
