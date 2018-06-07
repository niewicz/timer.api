class Api::UsersController < ApplicationController

  def show
    render :show, formats: :json
  end

  def update_billing_profile
    svc = Timer::Users::BillingProfiles::CreateOrUpdate.new(current_user, billing_profile_params)

    svc.on(:billing_profile_update_success) do |val|
      render :show, formats: :json
    end
    svc.on(:billing_profile_update_failure) do |errors|
      render json: errors, status: 422
    end

    svc.call
  end

  private

  def billing_profile_params
    params.require(:billing_profile).permit(
      :email,
      :person_name,
      :company_name,
      :phone,
      :address,
      :city,
      :postal_code,
      :country,
      :account_owner,
      :iban,
      :swift_code,
      :currency
    )
  end
end