class Timer::Summaries::Workload

  attr_reader :results, :total_time

  def initialize(user, params)
    @user = user.presence || fail(ArgumentError)
    @params = params.presence || fail(ArgumentError)
  end

  def call
    prepare_params!

    @results = []

    (@range_start.to_i..@range_end.to_i).step(1.days.to_i) do |date_i|
      total = 0

      start_i = Time.zone.at(date_i)
      end_i = Time.zone.at(date_i).end_of_day

      entries = @user.time_entries
        .where('end_at IS NOT NULL')
        .where('start_at >= ? AND start_at <= ? OR end_at >= ? AND end_at <= ? OR start_at < ? AND end_at > ?', 
          start_i, end_i, start_i, end_i, start_i, end_i
        )

      if entries.present?
        total = entries.map do |te| 
          if te.start_at >= start_i && te.end_at <= end_i
            te.total_time 
          elsif te.start_at >= start_i && te.end_at > end_i
            TimeEntry.new(start_at: te.start_at, end_at: end_i).total_time
          elsif te.start_at < start_i && te.end_at < end_i
            TimeEntry.new(start_at: start_i, end_at: te.end_at).total_time
          else
            24.hours.to_i
          end
        end.reduce(:+)
      end

      @results << { name: Time.at(date_i).to_date.to_s, value: total }
    end

    @total_time = @results.map{ |i| i[:value] }.reduce(:+) 
    @results
  end

  private 
  
  def prepare_params!

    if @params[:day_start].present? && @params[:day_end].present?
      @range_start = parse_date(@params[:day_start])
      @range_end = parse_date(@params[:day_end])
    else
      case @params[:time_range]
      when 'this_week'
        @range_start = Time.zone.now.beginning_of_week
        @range_end = Time.zone.now.end_of_week
      when 'this_month'
        @range_start = Time.zone.now.beginning_of_month
        @range_end = Time.zone.now.end_of_month
      when 'last_week'
        @range_start = Time.zone.now.last_week
        @range_end = Time.zone.now.last_week.end_of_week
      when 'last_month'
        @range_start = Time.zone.now.last_month
        @range_end = Time.zone.now.last_month.end_of_month  
      else
        @range_start = Time.zone.now.beginning_of_day - 6.days
        @range_end = Time.zone.now.beginning_of_day
      end
    end
  end

  def parse_date(date)
  end

end