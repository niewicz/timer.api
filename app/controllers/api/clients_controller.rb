class Api::ClientsController < ApplicationController

  def index
    clients = Timer::Clients::Get.new(current_user, params[:q]).call

    render json: clients
  end

  def show
    render json: client
  end

  def create
    svc = Timer::Clients::Create.new(current_user, client_params)

    svc.on(:client_create_success) do |val|
      render json: val
    end
    svc.on(:client_create_failure) do |errors|
      render json: errors, status: 422
    end

    svc.call
  end

  def edit
    render json: client
  end

  def update
    svc = Timer::Clients::Update.new(client, client_params)
    
    svc.on(:client_create_success) do |val|
      render json: val
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

  def client_params
    params.require(:client).permit(
      :name,
      :email,
      :contact_person_name,
      :contact_person_email
    )
  end

end