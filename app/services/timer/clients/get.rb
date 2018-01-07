class Timer::Clients::Get < Timer::BaseService

  attr_reader :total

  def initialize(user, params)
    @user = user.presence || fail(ArgumentError)
    @params = params.presence || {}
  end

  def call
    @ar_query = @user.clients

    search!

    @total = @ar_query.count

    order!
    offset!
    limit!

    @ar_query
  end

  private

  def search!
    return unless @params[:q]
    @ar_query = @ar_query.where('name ilike ?', "%#{@params[:q]}%")
  end

  def order!
    @ar_query = @ar_query.order('name ASC')
  end

  def offset!
    offset = @params[:offset] || 0
    @ar_query = @ar_query.offset(offset)
  end

  def limit!
    limit = @params[:limit].presence || 10
    @ar_query = @ar_query.limit(limit)
  end

end