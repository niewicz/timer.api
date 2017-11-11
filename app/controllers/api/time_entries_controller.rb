class TimeEntriesController < ApplicationController
  
  def index
    time_entries = Timer::TimeEntries::Get.new(current_user, filter_params).call

    render json: time_entries
  end

  def create
    svc = Timer::TimeEntries::Create.new(current_user, time_entry_params)

    svc.on(:time_entry_create_success) do |val|
      render json: val
    end
    svc.on(:time_entry_create_failure) do |errors|
      render json: errors, status: 422
    end

    svc.call
  end

  def update
    svc = Timer::TimeEntries::Update.new(time_entry, time_entry_params)
    
    svc.on(:time_entry_update_success) do |val|
      render json: val
    end
    svc.on(:time_entry_update_failure) do |errors|
      render json: errors, status: 422
    end

    svc.call
  end

  def destory
    svc = Timer::TimeEntries::Destroy.new(time_entry).call
    
    svc.on(:time_entry_destroy_success) do |val|
      head 204
    end
    svc.on(:time_entry_destroy_failure) do |val|
      head 422
    end

    svc.call
  end

  private

  def time_entry
    @time_entry ||= current_user.time_entries.find(params[:id])
  end

  def time_entry_params
    params.require(:time_entry).permit(
      :start_at,
      :end_at,
      :task_id
    )
  end

  def filter_params
    params.slice(
      :limit,
      :offset,
      :task_id,
      :client_id,
      :project_id,
      :since,
      :to
    )
  end
  
end