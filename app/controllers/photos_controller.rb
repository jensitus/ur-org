class PhotosController < ApplicationController
  before_action :set_photo
  respond_to :html, :js

  def destroy
    @photo.destroy
    #redirect_to :back
  end

  def show
    @comment = Comment.new
    @photo_users = @photo.photo_gallery.users
    @photo_comments = @photo.comments.order(:created_at)
    @gallery = @photo.photo_gallery.photos
    @gallery.each_with_index { |ph, i|
      if @photo == ph
        @i = i
        @previous = @gallery[i - 1]
        @next = @gallery[i + 1]
      end
    }
    respond_with @photo
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end
end
