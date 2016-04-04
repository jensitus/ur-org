class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include PublicActivity::StoreController
  around_action :catch_not_found
  protect_from_forgery with: :null_session #, if: Proc.new { |c| c.request.format == 'application/json' } #:exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :prepare_unobtrusive_flash

  respond_to :html, :json

  def after_sign_in_path_for(resource)
    home_path
  end

  def after_sign_out_path_for(resource)
    request.referrer
  end

  # hide_action :current_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :name    # {|u| u.permit (:name)} #, :avatar, :avatar_cache) }
    devise_parameter_sanitizer.for(:account_update) << :avatar
    devise_parameter_sanitizer.for(:sign_up) << :name           # {|u| u.permit(:name)} #, :avatar, :avatar_cache)}
    devise_parameter_sanitizer.for(:sign_up) << :avatar
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:name, :password, :password_confirmation, :invitation_token, :avatar)
    end
  end

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'muss das sein?'
    redirect_to request.referrer || root_url
  end

end
