class PhotosController < ApplicationController
  before_action :set_photo
  respond_to :html, :js
  def destroy
    @photo.destroy
    #redirect_to :back
  end
  private
  def set_photo
    @photo = Photo.find(params[:id])
  end
end
