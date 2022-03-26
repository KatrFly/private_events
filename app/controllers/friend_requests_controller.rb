class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @invitee = User.find(request_params[:invitee_id])
    @request = FriendRequest.create(inviter_id: current_user.id, invitee_id: @invitee.id)

    current_user.sent_friend_requests.reload
    redirect_to "/friendships"
  end

  def index
    @received_friend_requests = current_user.received_friend_requests
    @sent_friend_requests = current_user.sent_friend_requests
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
    current_user.sent_friend_requests.reload

    redirect_to "/friendships"
  end

  private

  def request_params
    params.permit(:_method, :invitee_id, :authenticity_token)
  end
end