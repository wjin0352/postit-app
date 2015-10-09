class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new
    if @user.save
      flash[:message] = "New user created successfully!"
    else
      render :back
  end



end

