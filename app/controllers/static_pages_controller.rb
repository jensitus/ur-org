class StaticPagesController < ApplicationController

  def home
    if user_signed_in?
      @micropost = current_user.microposts.build
      @placeholder = 'Compose your message to the world ...'
      @feed_items = current_user.feed.page(params[:page]).per(5)
      @likes = @micropost.likers(User)
      puts '########################################### :::::::    ++++     +*+*+*+'
      puts current_user.inspect
      puts '########################################### :::::::    ++++     +*+*+*+'
      @liked_by_current_user = @micropost.liked_by?(current_user)
      fresh_when :etag => [@feed_items, current_user]
    else
      @static_page_image = Micropost.where('picture IS NOT NULL').sample(1)[0].picture.url
      @microposts = Micropost.where('picture IS NULL AND group_id IS NULL').sample(3)
      #@likes = @micropost.likers(User)
      # redirect_to new_user_session_url
    end
  end

  def help
  end
end
