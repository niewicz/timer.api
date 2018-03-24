class Timer::TimeEntries::Get::Grouped < Timer::TimeEntries::Get

  def call
    @ar_query = @user.time_entries
    @ar_query = @ar_query.where('end_at IS NOT NULL')
    @total = @ar_query.count

    order!
    since!
    to!

    @ar_query
      .uniq(&:id)
      .group_by { |te| te.start_at.to_date }
  end

  private

  def since!
    since = @params[:since].presence || Time.zone.now
    since = since.is_a?(String) ? Time.zone.parse(since) : since
    @since = since.end_of_day
    @ar_query = @ar_query.where('start_at <= ?', @since)
  end

  def to!
    weeks_ago = @params[:weeks_ago].presence || 1
    to = @since - weeks_ago.weeks
    @ar_query = @ar_query.where('start_at >= ?', to)
  end

end