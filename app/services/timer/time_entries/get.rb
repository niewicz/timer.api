class Timer::TimeEntries::Get < Timer::BaseService

  def initialize(user, params)
    @user = user.presence || fail(ArgumentError)
    @params = params.presence || fail(ArgumentError)
  end

  def call
    @ar_query = @user.time_entries

    by_task!
    by_client!
    by_project!

    since!
    to!

    offset!
    limit!

    @ar_query
  end
  
  private

  def by_task!
  end

  def by_client!
  end

  def by_project!
  end

  def since!
  end

  def to!
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