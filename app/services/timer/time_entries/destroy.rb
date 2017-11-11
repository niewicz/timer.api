class Timer::TimeEntries::Destroy < Timer::BaseService
  include Wisper::Publisher
  
  def initialize(time_entry)
    @time_entry = time_entry.presence || fail(ArgumentError)
  end

  def call
    ActiveRecord::Base.transaction do
      if @time_entry.destroy
        broadcast(:time_entry_destroy_success, true)
      else
        broadcast(:time_entry_destroy_failure, false)
        fail(ActiveRecord::Rollback)
      end
    end
  end

end