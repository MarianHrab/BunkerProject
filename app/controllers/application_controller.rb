class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
    # Add any other required parameters
  end
  
  helper_method :current_user

    def current_user
      # Додайте свою логіку отримання поточного користувача
      # Наприклад, можливо, ви хочете використовувати сесії
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
