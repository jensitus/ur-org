class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.mailbox.conversations
    @notifications = current_user.mailbox.notifications.group_by &:sender_id
    @receipts = current_user.mailbox.receipts
    @message = current_user.mailbox.inbox.first.messages.first.body
  end

  def new
    @user = User.find(params[:user])
    @message = current_user.messages.new
    @followers = @user.followers.sample(3)
    @following = @user.following.sample(3)
    @galleries = @user.photo_galleries
  end

  def create
    @recipient = User.find(params[:recipient])
    current_user.send_message(@recipient, params[:body], params[:subject])
    flash[:notice] = "message has been sent, isn't it great?"
    redirect_to :conversations
  end

end
