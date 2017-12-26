class Timer::TimeEntries::Get < Timer::BaseService

  def initialize(user, params)
    @user = user.presence || fail(ArgumentError)
    @params = params.presence || {}
  end

  def call
    @ar_query = @user.time_entries
    @ar_query = @ar_query.where('end_at IS NOT NULL')

    by_task!

    since!
    to!

    order!
    offset!
    limit!

    @ar_query
  end
  
  private

  def by_task!
    return unless @params[:task_id].present?
    @ar_query = @ar_query.where(task_id: @params[:task_id])
  end

  def since!
    p 'not implemented!'
  end

  def to!
    p 'not implemented!'
  end

  def order!
    @ar_query = @ar_query.order('start_at DESC')
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