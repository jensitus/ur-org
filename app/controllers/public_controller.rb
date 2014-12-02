class PublicController < ApplicationController

  def index
    @users = User.all
  end

end