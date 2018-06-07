class Timer::Clients::Update < Timer::BaseService
  include Wisper::Publisher

  def initialize(client, params)
    @client = client.presence || fail(ArgumentError)
    @params = params.presence || fail(ArgumentError)
  end

  def call
    ActiveRecord::Base.transaction do
      @client.assign_attributes(@params)
      errors = Timer::Client::UpdateForm.call(@client.attributes).messages

      if errors.none? && @client.save(validate: false)
        broadcast(:client_update_success, @client)
      else
        broadcast(:client_update_failure, errors)
        fail(ActiveRecord::Rollback)
      end
    end
  end

end