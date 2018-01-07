class Timer::Projects::Get < Timer::BaseService
  
  attr_reader :total

  def initialize(user, params)
    @user = user.presence || fail(ArgumentError)
    @params = params.presence || {}
  end

  def call
    @ar_query = @user.projects

    by_client!
    search!

    @total = @ar_query.count

    order!
    offset!
    limit!
    
    @ar_query
  end

  private

  def by_client!
    return unless @params[:client_id].present?
    @ar_query = @ar_query.where(client_id: @params[:client_id])
  end

  def order!
    @ar_query = @ar_query.order('title ASC')
  end

  def search!
    return unless @params[:q].present?
    @ar_query = @ar_query.where('title ilike ?', "%#{@params[:q]}%")
  end

  def offset!
    offset = @params[:offset].presence || 0
    @ar_query = @ar_query.offset(offset)
  end

  def limit!
    limit = @params[:limit].presence || 10
    @ar_query = @ar_query.limit(limit)
  end

end