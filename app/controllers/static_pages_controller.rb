class StaticPagesController < ApplicationController

  respond_to :js

  def home
    if user_signed_in?
      redirect_to single_user_url(current_user)
      @micropost = current_user.microposts.build
      ########
      @photo = @micropost.photos.build
      ########
      @placeholder = 'Compose your message to the world ...'
      @sidebar_activities = current_user.newsfeed.first(10) # PublicActivity::Activity.order('created_at desc') #current_user.get_the_gallery_activities #.page(params[:page]).per(9)
      #@feed_items = current_user.get_the_microposts.page(params[:page]).per(8)
      the_real_feed = current_user.feed
      @the_real_feed = Kaminari.paginate_array(the_real_feed).page(params[:page]).per(13)
      #@latest_photo_comments = current_user.newsfeed
      @likes = @micropost.likers(User)
      @liked_by_current_user = @micropost.liked_by?(current_user)
      @following = current_user.following.sample(3)
      @followers = current_user.followers.sample(3)
      # @galleries = current_user.photo_galleries
      fresh_when :etag => [@the_real_feed, current_user]
      @hintergrund = current_user.custom_appearance
    else
      # if Rails.env.development?
      #   @static_page_image = Photo.find(60).picture
      # elsif Rails.env.production?
      #   @static_page_image = Photo.find(35).picture
      # end
      #@static_page_image = Micropost.where('picture IS NOT NULL').sample(1)[0].picture
      # @static_page_image = Photo.all.sample(1)[0].picture
      microposts = Micropost.where('picture IS NULL AND group_id IS NULL')
      @microposts = Kaminari.paginate_array(microposts).page(params[:page]).per(5)
      render :layout => 'not_signed_in'
    end
  end

  def about
  end

  def invitation_required

  end

end
