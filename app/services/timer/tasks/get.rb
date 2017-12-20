class Timer::Tasks::Get < Timer::BaseService

  def initialize(user, params)
    @user = user.presence || fail(ArgumentError)
    @params = params.presence || {}
  end

  def call
    @ar_query = @user.tasks

    by_project!
    by_client!
    search!

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

  def offset!
    offset = @params[:offset].presence || 0
    @ar_query = @ar_query.offset(offset)
  end

  def limit!
    limit = @params[:limit].presence || 10
    @ar_query = @ar_query.limit(limit)
  end

end