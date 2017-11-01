class Timer::Clients::Get < Timer::BaseService

  def initialize(user, q = nil, offset = 0, limit = 5)
    @user = user.presence || fail(ArgumentError)
    @q = q
    @offset = offset
    @limit = limit
  end

  def call
    clients = @user.clients
    clients.where('name LIKE ?', @q) if @q.present?
    clients.offset(@offset).limit(@limit)
  end

end