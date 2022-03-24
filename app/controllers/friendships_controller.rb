class FriendshipsController < ApplicationController
  def create
    @friend_request = FriendRequest.find(friendship_params[:friend_request])
    if Friendship.create(user_id: @friend_request.inviter_id, friend_id: current_user.id)
      flash.now[:notice] = "You are now friends with #{@friend_request.inviter.username}"
      @friend_request.destroy
      @received_friend_requests = current_user.received_friend_requests
      @sent_friend_requests = current_user.sent_friend_requests
      render "friend_requests/index"
    end
  end

  def index
    @friends = current_user.friends
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