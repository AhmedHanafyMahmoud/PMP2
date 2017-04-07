class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :reject_locked!, if: :devise_controller?

    # Auto-sign out locked users
  def reject_locked!
    if current_user && current_user.is_locked?
      sign_out current_user
      user_session = nil
      current_user = nil
      flash[:alert] = "Your account is locked."
      flash[:notice] = nil
      redirect_to root_url
    end
  end
  helper_method :reject_locked!
end
