class CustomAppearancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_custom_appearance

  def update
  end

  def show
    @check = current_user.id
    @hintergrund = current_user.custom_appearance
  end

  def change_color
    puts params[:user_id]
    puts params[:hintergrund]
    puts params[:navtext]
    @custom_appearance.update(navbar: params[:hintergrund], navtext: params[:navtext], linkcolor: params[:linkcolor])
    @hintergrund = current_user.custom_appearance
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

end
