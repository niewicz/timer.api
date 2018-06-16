class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  before_action :set_user_timezone
  protect_from_forgery with: :null_session, unless: :json_request?

  private

  def set_user_timezone
    Time.zone = current_user.timezone
  end

  def json_request?
    request.format.json?
  end

end
