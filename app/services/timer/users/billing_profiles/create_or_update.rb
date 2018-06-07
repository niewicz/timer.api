class Timer::Users::BillingProfiles::CreateOrUpdate < Timer::BaseService
  include Wisper::Publisher

  def initialize(user, params)
    @user = user.presence || fail(ArgumentError)
    @params = params.presence || fail(ArgumentError)
  end

  def call
    ActiveRecord::Base.transaction do 

      if @user.billing_profile.present?
        @user.billing_profile.assign_attributes(@params)
        billing_profile = @user.billing_profile
      else
        prepare_params!
        billing_profile = BillingProfile.new(@params)
      end
      errors = ::Timer::User::BillingProfile::DefaultForm.call(billing_profile.attributes).messages


      if errors.none? && billing_profile.save(validate: false)
        broadcast(:billing_profile_update_success, billing_profile)
      else
        broadcast(:billing_profile_update_failure, errors)
        fail(ActiveRecord::Rollback)
      end
    end
  end

  private 

  def prepare_params!
    @params.merge!(user_id: @user.id)
  end

end
