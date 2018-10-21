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
    current_user.send_message(@recipient, params[:body], params[:subject])
    # ReadPost.create(entity_type: m.class, user_id: @recipient.id)
    flash[:notice] = "message has been sent, isn't it great?"
    redirect_to :conversations
  end

  private

  def send_message(recipients, msg_body, subject, sanitize_text = true, attachment = nil, message_timestamp = Time.now)
    convo = Mailboxer::ConversationBuilder.new({
                                                   :subject => subject,
                                                   :created_at => message_timestamp,
                                                   :updated_at => message_timestamp
                                               }).build
    puts "convo!"
    puts convo
    message = Mailboxer::MessageBuilder.new({
                                                :sender => self,
                                                :conversation => convo,
                                                :recipients => recipients,
                                                :body => msg_body,
                                                :subject => subject,
                                                :attachment => attachment,
                                                :created_at => message_timestamp,
                                                :updated_at => message_timestamp
                                            }).build

    message.deliver false, sanitize_text
  end

end
