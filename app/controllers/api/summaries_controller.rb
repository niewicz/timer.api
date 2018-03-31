class Api::SummariesController < ApplicationController

  def workload_chart
    results = ::Timer::Summaries::Workload.new(current_user, params).call

    render json: { 
      data: results, 
      total: results.map{ |i| i[:value] }.reduce(:+) 
    }
  end

end