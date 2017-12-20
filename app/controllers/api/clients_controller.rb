class Api::ClientsController < ApplicationController

  def index
    @clients = Timer::Clients::Get.new(current_user, filter_params).call
    render :index, formats: :json
  end

  def show
    client
    render :show, formats: :json
  end

  def create
    svc = Timer::Clients::Create.new(current_user, client_params)

    svc.on(:client_create_success) do |val|
      @client = val
      render :create, formats: :json
    end
    svc.on(:client_create_failure) do |errors|
      render json: errors, status: 422
    end

    svc.call
  end

  def edit
    client
    render :edit, formats: :json
  end

  def update
    svc = Timer::Clients::Update.new(client, client_params)
    
    svc.on(:client_create_success) do |val|
      @client = val
      render :update, formats: :json
    end
    svc.on(:client_create_failure) do |errors|
      render json: errors, status: 422
    end

    svc.call
  end

  def destory
    svc = Timer::Clients::Destroy.new(client).call

    svc.on(:client_destroy_success) do |val|
      head 204
    end
    svc.on(:client_destroy_failure) do |val|
      head 422
    end

    svc.call
  end

  private

  def client
    @client ||= current_user.clients.find(params[:id])
  end

  def filter_params
    params.slice(
      :q,
      :limit,
      :offset
    )
  end

  def client_params
    params.require(:client).permit(
      :name,
      :email,
      :contact_person_name,
      :contact_person_email
    )
  end

end