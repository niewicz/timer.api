class Api::SummariesController < ApplicationController

  def workload_chart
    current_user.time_entries
      .where('end_at is not null')
      .where('start_at > ?', Time.zone.now.utc.beginning_of_day - 7.days)
      .group_by(&:day_of_entry)
      .map{ |g| 
        { 
          date: g[0],
          data: Time.at(g[1].map{ |te| te.total_time }.reduce(:+)).utc.strftime('%H:%M')
        }
      }
  end

end