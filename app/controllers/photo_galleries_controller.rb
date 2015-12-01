class PhotoGalleriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_photo_gallery, only: [:show, :edit, :update, :destroy]
  before_action :photo_gallery_user, only: [:edit, :update, :destroy]
  before_action :the_index, only: :index
  before_action :photo_gallery_params_nil, only: [:create, :update]

  respond_to :html

  def index
    @photo_galleries = PhotoGallery.all
    respond_with(@photo_galleries)
  end

  def show
    @photos = @photo_gallery.photos
    respond_with(@photo_gallery)
  end

  def new
    @photo_gallery = PhotoGallery.new
    respond_with(@photo_gallery)
    @photo = @photo_gallery.photos.build
  end

  def edit
    @photos = @photo_gallery.photos
  end

  def create
    @photo_gallery = current_user.photo_galleries.build(photo_gallery_params) # PhotoGallery.new(photo_gallery_params)
    @photo_gallery.users << current_user
    if @photo_gallery.save
      if params[:photos].nil?
        puts '??????????????????????????????????????????'
        puts 'the fucking photo params are not what they are expected'
      else
        params[:photos]['picture'].each do |photo|
          @photo = @photo_gallery.photos.create!(picture: photo, photo_gallery_id: @photo_gallery.id)
        end
      end
    end
    redirect_to(@photo_gallery)
  end

  def update
    if @photo_gallery.update(photo_gallery_params)
      if params[:photos].nil?
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        puts 'the photos is nil'
      else
        puts '++++++++++++++++++++++++++++++++'
        puts params[:photos]
        params[:photos]['picture'].each do |photo|
          @photo = @photo_gallery.photos.create!(picture: photo, photo_gallery_id: @photo_gallery.id)
        end
      end
      flash[:success] = 'jepp'
    end
    respond_with(@photo_gallery)
  end

  def destroy
    @photo_gallery.destroy
    respond_with(@photo_gallery)
  end

  private

    def set_photo_gallery
      @photo_gallery = PhotoGallery.find(params[:id])
    end

    def photo_gallery_params
      params.require(:photo_gallery).permit(:title, :description, photos_attributes: [:id, :photo_gallery_id, :picture])
    end

    def photo_gallery_user
      if !@photo_gallery.users.include? current_user
        flash[:danger] = 'so nicht!'
        redirect_to root_path
      end
    end

    def the_index
      if !current_user.admin?
        flash[:danger] = 'langsam wirds fad'
        redirect_to root_path
      end
    end

    def photo_gallery_params_nil
      photo_gallery_params.each do |param|
        if param[0] == 'title'
          if !param[1] == ''

          elsif param[1] == ''
            flash[:danger] = 'maaahh'
            redirect_to request.referer
          end
        end
      end
    end

end
