class Api::SummariesController < ApplicationController

  def workload_chart
    range_start = Time.now.utc.beginning_of_day - 6.days
    range_end = Time.now.utc.beginning_of_day

    results = []

    (range_start.to_i..range_end.to_i).step(1.days.to_i) do |date_i|
      total = 0

      entries = current_user.time_entries
        .where('end_at IS NOT NULL')
        .where('start_at > ? AND start_at < ?', 
          Time.at(date_i), Time.at(date_i).end_of_day
        )

      if entries.present?
        total = entries.map{ |te| te.total_time }.reduce(:+)
      end

      results << { name: Time.at(date_i).to_date.to_s, value: total }
    end

    render json: { data: results }
  end

end