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
    puts "THIS IS NEW GOD DAMN"
    @message = current_user.messages.new
    @followers = @user.followers.sample(3)
    @following = @user.following.sample(3)
    @galleries = @user.photo_galleries
  end

  def create
    @recipient = User.find(params[:recipient])
    puts " IS THIS REALLY THE ANSWER?"
    m = current_user.send_message(@recipient, params[:body], params[:subject])
    puts "m m m m m m m m m m m m m m m m m m m m m"
    puts m
    puts m.inspect
    c = m.conversation
    puts c.inspect
    ReadPost.create(entity_type: c.class, user_id: @recipient.id, read: false, entity_type_id: c.id)
    flash[:notice] = "message has been sent, isn't it great?"
    redirect_to :conversations
  end

end
