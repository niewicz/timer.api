class Timer::Clients::Create < Timer::BaseService
  include Wisper::Publisher

  def initialize(user, params)
    @user = user.presence || fail(ArgumentError)
    @params = params.presence || fail(ArgumentError)
  end

  def call
    ActiveRecord::Base.transaction do
      client = @user.clients.new(@params)
      errors = Timer::Client::CreateForm.call(client.attributes).messages

      if errors.none? && client.save(validate: false)
        broadcast(:client_create_success, client)
      else
        broadcast(:client_create_failure, errors)
        fail(ActiveRecord::Rollback)
      end
    end
  end

end