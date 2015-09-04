class StaticPagesController < ApplicationController

  respond_to :js

  def home
    if user_signed_in?
      @micropost = current_user.microposts.build
      ########
      @photo = @micropost.photos.build
      ########
      @placeholder = 'Compose your message to the world ...'
      @feed_items = current_user.feed.page(params[:page]).per(5)
      @likes = @micropost.likers(User)
      @liked_by_current_user = @micropost.liked_by?(current_user)
      @following = current_user.following.sample(3)
      @followers = current_user.followers.sample(3)
      fresh_when :etag => [@feed_items, current_user]
    else
      @static_page_image = Micropost.where('picture IS NOT NULL').sample(1)[0].picture
      # @static_page_image = Photo.all.sample(1)[0].picture
      @microposts = Micropost.where('picture IS NULL AND group_id IS NULL').sample(3)
    end

  end

  def about
  end

  private

  # def the_search
  #   s = PgSearch.multisearch(params[:query])
  #   q = params[:query]
  #   puts '###################################################'
  #   q = q.strip if !q.nil?
  #   puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  #   puts s.class
  #   puts s.inspect
  #   puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  #   puts 'q'
  #   puts q.inspect
  #   the_search = {}
  #   s.each do |s|
  #     search = Scalpel.cut s.content
  #     search.each do |se|
  #       puts '::::::::::::::::::::::'
  #       puts se if se.downcase.include?(q.downcase)
  #       @se = se if se.downcase.include?(q.downcase)
  #       puts '@se: ' + @se
  #       puts se.downcase.include?(q.downcase)
  #       puts se.inspect
  #       puts ':::::::::::::::::::::::::::::::::::::'
  #       the_search = {s: s, se: se}
  #     end
  #     puts 'the_search:'
  #     puts the_search
  #     the_search
  #   end
  #
  #
  #   puts '##### ##############################################'
  # end

end
