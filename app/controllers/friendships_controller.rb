class FriendshipsController < ApplicationController
  def create
    @inviter = User.find(friendship_params[:inviter_id])
    
    if Friendship.create(user_id: friendship_params[:inviter_id], friend_id: current_user.id)
      flash.now[:notice] = "You are now friends with #{@inviter.username}"
      
      render "friend_requests/index"
    end
  end

  def index
    # @friends = User.find_by_sql("SELECT * FROM users JOIN friendships ON user.id = user_id WHERE friend_id = #{current_user.id} JOIN friendships ON friend_id = user.id WHERE user_id = #{current_user.id}")
    @friends = User.all
    @users = User.all
  end

  def show

  end

  private
  
  def friendship_params
    params.permit(:_method, :inviter_id, :authenticity_token, :friend_request)
  end
end