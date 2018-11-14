# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!, :set_locale

  include Pundit

  # Pundit: white-list approach.

  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username avatar])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username avatar])
  end

  def set_locale
    # Warning, the normal configuration is: I18n.locale = params.fetch(:locale, I18n.default_locale).to_sym
    # This choice is made so that the Rails Console remains in config.i18n.default_locale =: en
    # and that the Rails Server remains on locale =: fr
    I18n.locale = params.fetch(:locale, :fr).to_sym
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  protected

  def after_sign_in_path_for(resource)
    # facebook or google connect OR access to page requested by log out user OR choice_path
    request.env['omniauth.origin'] || stored_location_for(resource) || pages_dashboard_path
  end
end
