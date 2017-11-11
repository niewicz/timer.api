class Timer::TimeEntries::Create < Timer::BaseService
  include Wisper::Publisher

  def initialize(user, params)
    @user = user.presence || fail(ArgumentError)
    @params = params.presence || fail(ArgumentError)
  end

  def call
    prepare_params!
    ActiveRecord::Base.transaction do 
      time_entry = @user.time_entries.new(@params)
      errors = ::Timer::TimeEntry::CreateForm.call(time_entry.attributes).messages

      if errors.none? && time_entry.save(validate: false)
        broadcast(:time_entry_create_success, time_entry)
      else
        broadcast(:time_entry_create_failure, errors)
        fail(ActiveRecord::Rollback)
      end
    end
  end

  private

  def prepare_params!
    @params[:start_at] = DateTime.parse(@params[:start_at])
    @params[:end_at] = DateTime.parse(@params[:end_at]) if @params[:end_at].present?
  end

end
