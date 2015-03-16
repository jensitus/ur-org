class StaticPagesController < ApplicationController

  def home
    if user_signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.page(params[:page]).per(5)

      fresh_when :etag => [@feed_items, current_user]
    else
      @static_page_image = Micropost.where('picture IS NOT NULL').sample(1)[0].picture.url
      @micropost = Micropost.where('picture IS NULL').sample(3)
      # redirect_to new_user_session_url
    end
  end

  def help
  end
end
