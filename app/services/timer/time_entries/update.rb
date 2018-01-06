class Timer::TimeEntries::Update < Timer::BaseService
  include Wisper::Publisher
  
  def initialize(user, time_entry, params)
    @user = user.presence || fail(ArgumentError)
    @time_entry = time_entry.presence || fail(ArgumentError)
    @params = params.presence || fail(ArgumentError)
  end

  def call
    prepare_params!
    ActiveRecord::Base.transaction do 
      @time_entry.assign_attributes(@params)
      errors = ::Timer::TimeEntry::CreateForm.call(@time_entry.attributes).messages

      if errors.none? && @time_entry.save(validate: false)
        @user.tasks.includes(:time_entries).where(time_entries: {task_id: nil}).destroy_all
        broadcast(:time_entry_update_success, @time_entry)
      else
        broadcast(:time_entry_update_failure, errors)
        fail(ActiveRecord::Rollback)
      end
    end
  end

  private

  def prepare_params!
    @params[:start_at] = DateTime.parse(@params[:start_at]) if @params[:start_at].present?
    @params[:end_at] = DateTime.parse(@params[:end_at]) if @params[:end_at].present?
  end

end
  