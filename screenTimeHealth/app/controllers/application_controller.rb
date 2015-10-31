class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?


  # Update page to redirect to after successful sign in
  def after_sign_in_path_for(resource)
    family_view_path
  end



  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:surname, :email, :password)}
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :surname) }
    # devise_parameter_sanitizer.for(avatar_upload_complete_url) { |u| u.permit(:email, :password, :password_confirmation, :is_over_legal_age, :firstname, :lastname, :telephone, :current_password, :avatar, :avatar_cache) }
  end

end
