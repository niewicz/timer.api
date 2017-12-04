class Api::ProjectsController < ApplicationController
  
  def index
    @projects = Timer::Projects::Get.new(current_user, filter_params).call
    render :index, formats: :json
  end

  def show
    render json: project
  end

  def create
    svc = Timer::Projects::Create.new(current_user, project_params)
    
    svc.on(:project_create_success) do |val|
      render json: val
    end
    svc.on(:project_create_failure) do |errors|
      render json: errors, status: 422
    end

    svc.call
  end

  def edit
    render json: project
  end

  def update
    svc = Timer::Projects::Update.new(project, project_params)
    
    svc.on(:project_update_success) do |val|
      render json: val
    end
    svc.on(:project_update_failure) do |errors|
      render json: errors, status: 422
    end

    svc.call
  end

  def destroy
    svc = Timer::Projects::Destroy.new(project).call
    
    svc.on(:project_destroy_success) do |val|
      head 204
    end
    svc.on(:project_destroy_failure) do |val|
      head 422
    end

    svc.call
  end
  
  private

  def project
    @project ||= current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:proejct).permit(
      :title,
      :description,
      :client_id
    )
  end

  def filter_params
    params.slice(
      :q,
      :client_id,
      :limit,
      :offset
    )
  end

end