class Timer::Tasks::Get < Timer::BaseService
  ORDER_BY = ['id', 'title', 'created_at', 'updated_at'].freeze
  ORDERS = ['ASC', 'DESC'].freeze

  def initialize(user, params)
    @user = user.presence || fail(ArgumentError)
    @params = params.presence || {}
  end

  def call
    @ar_query = @user.tasks

    by_project!
    by_client!
    search!
    order!

    offset!
    limit!
    
    @ar_query
  end

  private

  def by_project!
    return unless @params[:project_id].present?
    @ar_query = @ar_query.where(project_id: @params[:project_id])
  end

  def by_client!
    return unless @params[:client_id].present?
    @ar_query = @ar_query.where(client_id: @params[:client_id])
  end

  def search!
    return unless @params[:q].present?
    @ar_query = @ar_query.where('title ilike ?', "%#{@params[:q]}%")
  end

  def order! 
    return unless @params[:order_by].present? && 
      ORDER_BY.include?(@params[:order_by]) &&
      @params[:order].present? &&
      ORDERS.include?(@params[:order]) 
    @ar_query = @ar_query.order("#{@params[:order_by]} #{@params[:order]}")
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