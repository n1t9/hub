class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_locale

  def current_user
    return nil unless session[:session_token]

    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  helper_method :current_user

  def create_session(user)
    session[:session_token] = user.session_token
  end

  private

  def set_locale
    I18n.locale = current_user&.language || I18n.default_locale
  end
end
