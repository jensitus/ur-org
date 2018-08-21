class MobileNavController < ApplicationController

  def show_sidebar
    @user = current_user
    @hintergrund = current_user.custom_appearance
    @following = current_user.following.sample(3)
    @followers = current_user.followers.sample(3)
  end

  def stats
    @user = current_user
    @hintergrund = current_user.custom_appearance
    @following = current_user.following.sample(3)
    @followers = current_user.followers.sample(3)
  end

end
