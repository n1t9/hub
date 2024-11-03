class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_user
    return nil unless session[:session_token]

    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  helper_method :current_user

  def create_session(user)
    session_token = SecureRandom.alphanumeric(16)
    user.update(session_token:)
    session[:session_token] = session_token
  end
end
