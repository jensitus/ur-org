class StaticPagesController < ApplicationController

  def home
    if user_signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 5)

      fresh_when :etag => [@feed_items, current_user]
    end
  end

  def help
  end
end
