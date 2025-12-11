# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    pseudo = resource.member&.pseudo || resource.email
    flash[:notice] = " Transmission sécurisée réussie! Bienvenue sur Dragon Krayt A'den, #{pseudo} !"
    stored_location_for(resource) || request.referer || root_path
  end

  def after_sign_in_failure_path_for(resource)
    root_path(login_failed: true)
  end

  def after_resetting_password_path_for(resource)
    root_path()   # Ouvre ta modale login
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
