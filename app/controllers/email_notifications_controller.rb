class EmailNotificationsController < ApplicationController
  before_action :set_email_notification, only: :update

  def new
    @email_notification = EmailNotification.new
    respond_with(@email_notification)
  end

  def create
    @email_notification = EmailNotification.new(email_notification_params)
    if @email_notification.save
      puts @email_notification.inspect
      flash[:success] = "too bad, you won't get email notifications anymore for this post"
      @m_id = @email_notification.micropost_id
    else
      flash[:warning] = 'mist'
    end
  end

  def update
    @email_notification.update(email_notification_params)
    puts @email_notification.inspect
    @m_id = @email_notification.micropost_id
  end

  def delete
  end

  private

  def email_notification_params
    params.require(:email_notification).permit(:user_id, :micropost_id, :emails)
  end

  def set_email_notification
    @email_notification = EmailNotification.find(params[:id])
  end

end
