class Api::TimeEntriesController < ApplicationController
  
  def index
    svc = Timer::TimeEntries::Get.new(current_user, filter_params)
    @time_entries = svc.call
    @total = svc.total

    render :index, formats: :json
  end

  def index_grouped
    svc = Timer::TimeEntries::Get::Grouped.new(current_user, filter_params)
    @grouped_time_entries = svc.call
    @total = svc.total

    p @grouped_time_entries
    render :index_grouped, formats: :json
  end

  def current
    @time_entry = Timer::TimeEntries::Current.new(current_user).call
    render :current, formats: :json
  end

  def create
    svc = Timer::TimeEntries::Create.new(current_user, time_entry_params)

    svc.on(:time_entry_create_success) do |val|
      @time_entry = val
      render :create, formats: :json
    end
    svc.on(:time_entry_create_failure) do |errors|
      render json: errors, status: 422
    end

    svc.call
  end

  def update
    svc = Timer::TimeEntries::Update.new(current_user, time_entry, time_entry_params)
    
    svc.on(:time_entry_update_success) do |val|
      @time_entry = val
      render :update, formats: :json
    end
    svc.on(:time_entry_update_failure) do |errors|
      render json: errors, status: 422
    end

    svc.call
  end

  def destroy
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
      :task_id,
      :project_id,
    )
  end

  def filter_params
    params.permit(
      :limit,
      :offset,
      :task_id,
      :since,
      :to
    ).to_h
  end
  
end