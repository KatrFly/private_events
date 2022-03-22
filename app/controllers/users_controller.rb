class UsersController < ApplicationController
  def show
    if user_signed_in?
      @user = User.find(params[:id])
    else
      render "login_required"
    end
  end

  def index
    @users = User.all
  end
end
 