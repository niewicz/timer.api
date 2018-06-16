class Timer::Users::SetTimezone < Timer::BaseService
  include Wisper::Publisher

  def initialize(user, timezone)
    @user = user.presence || fail(ArgumentError)
    @timezone = timezone.presence || fail(ArgumentError)
  end

  def call
    ActiveRecord::Base.transaction do 

      p @timezone
      @user.assign_attributes(timezone: @timezone)
      p @user
      errors = ::Timer::User::SetTimezoneForm.call(@user.attributes).messages


      if errors.none? && @user.save(validate: false)
        broadcast(:set_timezone_success, @user)
      else
        broadcast(:set_timezone_failure, errors)
        fail(ActiveRecord::Rollback)
      end
    end
  end

  private 

  def prepare_params!
    @params.merge!(user_id: @user.id)
  end

end
