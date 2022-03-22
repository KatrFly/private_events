class FriendshipsController < ApplicationController
  def create
    @friend_request = FriendRequest.find(friendship_params[:friend_request])
    if Friendship.create(user_id: @friend_request.inviter, friend_id: current_user)
      flash.now[:notice] = "You are now friends with #{@friend_request.inviter.username}"
      @friend_request.destroy
      redirect_to friend_requests_path
    end
  end

  def index
    # @friends = User.find_by_sql("SELECT * FROM users JOIN friendships ON user.id = user_id WHERE friend_id = #{current_user.id} JOIN friendships ON friend_id = user.id WHERE user_id = #{current_user.id}")
    @friends = User.all
    @users = User.all
  end

  def show

  end

  def destroy
    
  end

  private
  
  def friendship_params
    params.permit(:_method, :authenticity_token, :friend_request)
  end
end