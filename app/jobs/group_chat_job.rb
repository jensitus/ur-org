class GroupChatJob < ApplicationJob
  queue_as :default

  def perform(posting)
    # Do something later
    ActionCable.server.broadcast "group_#{posting.group_id}_channel", message: render_posting(posting)
  end

  private

  def render_posting(posting)
    GroupsController.render partial: 'groups/add_posting', locals: {micropost: posting}
  end

end
