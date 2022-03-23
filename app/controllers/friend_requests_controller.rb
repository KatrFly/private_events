class FriendRequestsController < ApplicationController
  def new
    @request = FriendRequest.new
  end

  def create
    @invitee = User.find(request_params[:invitee_id])
    @request = FriendRequest.new(inviter_id: current_user.id, invitee_id: @invitee.id)
    @request.save
    @users = User.all
    @friends = current_user.friends
    current_user.sent_friend_requests.reload
    render "friendships/index"
  end

  def index
    @received_friend_requests = current_user.received_friend_requests
    @sent_friend_requests = current_user.sent_friend_requests
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
    current_user.sent_friend_requests.reload
    @friends = current_user.friends
    @users = User.all
    render "friendships/index"
  end

  private

  def request_params
    params.permit(:_method, :invitee_id, :authenticity_token)
  end
end