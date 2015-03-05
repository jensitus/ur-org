class MessagesController < ApplicationController

  def index
    @conversations = current_user.mailbox.conversations
    @notifications = current_user.mailbox.notifications.group_by &:sender_id
    @receipts = current_user.mailbox.receipts
    @message = current_user.mailbox.inbox.first.messages.first.body
  end

  def new
    @user = User.find(params[:user])
    @message = current_user.messages.new
  end

  def create
    @recipient = User.find(params[:user])
    current_user.send_message(@recipient, params[:body], params[:subject])
    flash[:notice] = "message has been sent, isn't it great?"
    #byebug
    redirect_to :conversations
  end

end
#   before_filter :authenticate_user!
#   before_filter :get_mailbox, :get_box, :get_actor
#
#   def index
#     redirect_to conversations_path(:box => @box)
#   end
#
# # GET /messages/1
# # GET /messages/1.xml
#   def show
#     if @message = Message.find_by_id(params[:id]) and @conversation = @message.conversation
#       if @conversation.is_participant?(@actor)
#         redirect_to conversation_path(@conversation, :box => @box, :anchor => "message_" + @message.id.to_s)
#         return
#       end
#     end
#     redirect_to conversations_path(:box => @box)
#   end
#
# # GET /messages/new
# # GET /messages/new.xml
#   def new
#     # if params[:receiver].present?
#     #   @recipient = User.find_by_slug(params[:receiver])
#     #   return if @recipient.nil?
#     #   @recipient = nil if Actor.normalize(@recipient)==Actor.normalize(current_subject)
#     # end
#   end
#
# # GET /messages/1/edit
#   def edit
#   end
#
# # POST /messages
# # POST /messages.xml
#   def create
#     @recipients =
#       if params[:recipients].present?
#         @recipients = params[:recipients].split(',').map{ |r| User.find_by_name(r) }
#       else
#         []
#       end
#     byebug
#     @receipt = current_user.send_message(@recipients, params[:body], params[:subject])
#     byebug
#     if (@receipt.errors.blank?)
#       @conversation = @receipt.conversation
#       flash[:success]= t('mailboxer.sent')
#       redirect_to conversations_path #(@conversation, :box => :sentbox)
#     else
#       render :action => :new
#     end
#   end
#
#   def reply
#     receipts = conversation.receipts_for current_user
#     receipts.each do |receipt|
#       current_user.reply_to_sender(receipt, message_params)
#       byebug
#     end
#     #*message_params(:body, :subject))
#     byebug
#     redirect_to root_url
#   end
#
# # PUT /messages/1
# # PUT /messages/1.xml
#
#   def update
#   end
#
# # DELETE /messages/1
# # DELETE /messages/1.xml
#   def destroy
#   end
#
#   private
#
#   def get_mailbox
#     @mailbox = current_user.mailbox
#   end
#
#   def get_actor
#     #@actor = User.normalize(current_user)
#   end
#
#   def get_box
#     if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
#       @box = "inbox"
#       return
#     end
#     @box = params[:box]
#   end
# end