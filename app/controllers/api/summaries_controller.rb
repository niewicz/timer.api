class Api::SummariesController < ApplicationController

  def workload_chart
    svc = ::Timer::Summaries::Workload.new(current_user, params)
    @results = svc.call
    @total = svc.total_time

    render :workload_chart, formats: :json
  end

  def last_projects
    @projects = current_user.projects.order('id DESC').limit(4)

    render :last_projects, formats: :json
  end

end