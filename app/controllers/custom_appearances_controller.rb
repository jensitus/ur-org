class CustomAppearancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_custom_appearance
  before_action :set_hintergrund

  def update
  end

  def show
    @check = current_user.id
    @blogrolls = @hintergrund.blogrolls
  end

  def change_color
    puts params[:user_id]
    puts params[:hintergrund]
    puts params[:navtext]
    @custom_appearance.update(navbar: params[:hintergrund], navtext: params[:navtext], linkcolor: params[:linkcolor])
    respond_to do |format|
      format.js
    end
  end

  def blogroll
    puts params[:url]
    puts params[:description]
    puts params[:custom_appearance_id]
    url_str = params[:url]
    validdom = PublicSuffix.valid?(url_str.sub(/\Ahttps?\:\/\/(www.)?/, ''))
    puts validdom.inspect
    if validdom == true
      @blogroll = Blogroll.create(url: params[:url], description: params[:description], custom_appearance_id: params[:custom_appearance_id])
    else
      flash[:warning] = 'not a valid url'
    end
    respond_to do |format|
      format.js
    end
  end

  def delete_blog
    puts "- - - - - - - - -"
    puts params[:blogroll_id]
    current_user.custom_appearance.blogrolls.delete(params[:blogroll_id])
    @blogrolls = @hintergrund.blogrolls
    respond_to do |format|
      format.js
    end
  end

  private

  def set_custom_appearance
    c_a = CustomAppearance.find_by_user_id current_user.id
    if !c_a.nil? && c_a.user_id == current_user.id
      @custom_appearance = c_a
    else
      redirect_to :root
    end
  end

  def set_hintergrund
    @hintergrund = current_user.custom_appearance
  end

end
