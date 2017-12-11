class Timer::TimeEntries::Current < Timer::BaseService
  
  def initialize(user)
    @user = user.presence || fail(ArgumentError)
  end

  def call
    @user.time_entries.where('end_at IS NULL').last
  end
    
end