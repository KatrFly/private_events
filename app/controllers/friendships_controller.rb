class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friend_request = FriendRequest.find(friendship_params[:friend_request])
    if Friendship.create(user_id: @friend_request.inviter_id, friend_id: current_user.id)
      flash.now[:notice] = "You are now friends with #{@friend_request.inviter.username}"
      @friend_request.destroy
      redirect_to "/friend_requests"
    end
  end

  def index
    @friends = current_user.friends
    @friendships = Friendship.where(user_id: current_user.id).or(Friendship.where(friend:current_user.id))
    @users = User.all
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    
     respond_to do |format|
      format.html { redirect_to friend_requests_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
  def friendship_params
    params.permit(:_method, :authenticity_token, :friend_request)
  end
end