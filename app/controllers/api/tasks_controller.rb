class Api::TasksController < ApplicationController
  
  def index
    @tasks = Timer::Tasks::Get.new(current_user, filter_params).call
    render :index, formats: :json
  end

  def show
    task
    render :show, formats: :json
  end

  def create
    svc = Timer::Tasks::Create.new(current_user, task_params)
    
    svc.on(:task_create_success) do |val|
      @task = val
      render :create, formats: :json
    end
    svc.on(:task_create_failure) do |errors|
      render json: errors, status: 422
    end

    svc.call
  end

  def edit
    render json: task
  end

  def update
    svc = Timer::Tasks::Update.new(task, task_params)
    
    svc.on(:task_update_success) do |val|
      render :update, formats: :json
    end
    svc.on(:task_update_failure) do |errors|
      render json: errors, status: 422
    end

    svc.call
  end

  def destroy
    svc = Timer::Tasks::Destroy.new(task).call
    
    svc.on(:task_destroy_success) do |val|
      head 204
    end
    svc.on(:task_destroy_failure) do |val|
      head 422
    end

    svc.call
  end

  private

  def task
    @task ||= current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(
      :title,
      :price,
      :data,
      :project_id,
      :client_id
    )
  end

  def filter_params
    params.permit(
      :q,
      :limit,
      :offset,
      :order,
      :order_by,
      :project_id,
      :client_id
    ).to_h
  end
  
end