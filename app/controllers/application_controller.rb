class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up, keys: [:firstame])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:firstame])

	  devise_parameter_sanitizer.permit(:sign_up, keys: [:lastname])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:lastname])
  end

  before_action :set_locale
 
  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end
 
    I18n.locale = session[:locale] || I18n.default_locale
   end
end
