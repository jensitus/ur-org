class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :mailbox

  def index
    @notifications ||= @mailbox.notifications.page(params[:page]).per(10)
    @all_notifications_count ||= @mailbox.notifications(read: false).count
    # @galleries = current_user.photo_galleries
    # @latest_photo_comments = current_user.latest_photo_comments.limit(10)
    # @mailbox.notifications(read: false).each do |unread|
    #   unread.mark_as_read current_user
    # end
  end

  def show
    @notification = Mailboxer::Notification.find(params[:id])
    @notification.mark_as_read current_user
    redirect_to notifications_index_path
  end

  def render_read
    @mailbox.notifications(read: false).each do |unread|
      unread.mark_as_read current_user
    end
    redirect_to root_url
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

end
