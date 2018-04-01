class Api::SummariesController < ApplicationController

  def workload_chart
    svc = ::Timer::Summaries::Workload.new(current_user, params)
    @results = svc.call
    @total = svc.total_time

    render :workload_chart, formats: :json
  end

  def last_projects

  end

end