class Timer::Clients::Destroy < Timer::BaseService
  include Wisper::Publisher
  
  def initialize(client)
    @client = client.presence || fail(ArgumentError)
  end

  def call
    ActiveRecord::Base.transaction do
      if @client.destroy
        broadcast(:client_destroy_success, true)
      else
        broadcast(:client_destroy_failure, false)
        fail(ActiveRecord::Rollback)
      end
    end
  end

end