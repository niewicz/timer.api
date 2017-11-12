class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  protect_from_forgery with: :null_session, unless: :json_request?

  private

  def json_request?
    request.format.json?
  end

end
