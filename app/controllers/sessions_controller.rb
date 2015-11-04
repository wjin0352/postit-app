class SessionsController < ApplicationController

  def new
  end

  def create
    # user.authenticate = "password"
    # 1. get user object (so how do we get the user obj? use binding.pry to see )
    # 2. see if password matches (use authenticate method)
    # 3. if so, login
    # 4. if not, then error message
    user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        if user.two_factor_auth?
          session[:two_factor] = true
          # generate pin number save to db
          user.create_pin!
          # send sms to twillio, send user pin number to use

          # show a form to enter pin number (create a route for this form, get and post)
          redirect_to pin_path
        else
          successful_login!(user)
        end
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

  def pin
    # denies access to /pin unless sessions[:two_factor] is true. which is only set in create action.
    access_denied if session[:two_factor].nil?

    if request.post?
      user = User.find_by(pin: params[:pin])
        if user
          session[:two_factor] = nil
        # destroy the pin number
          user.destroy_pin!
          successful_login!(user)
        else
          flash['error'] = "Sorry, somethings wrong with your pin number"
          redirect_to pin_path
        end
    end

  end

  private

    def successful_login!(user)
      session[:user_id] = user.id
      flash['notice'] = "You've successfully logged in"
      redirect_to root_path
    end
end
