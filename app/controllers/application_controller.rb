class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  before_action :set_user_timezone
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :null_session, unless: :json_request?

  private

  def set_user_timezone
    if current_user
      Time.zone = current_user.timezone
    end
  end

  def json_request?
    request.format.json?
  end

  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :timezone])
  end

end
