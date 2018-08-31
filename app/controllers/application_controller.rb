class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters

    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
  end

  protected

  def after_sign_in_path_for(resource)
    # facebook or google connect OR access to page requested by log out user OR choice_path
    request.env['omniauth.origin'] || stored_location_for(resource) || items_path
  end

end
