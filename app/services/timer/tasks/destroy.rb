class Timer::Tasks::Destroy < Timer::BaseService
  
  def initialize(task)
    @task = task.presence || fail(ArgumentError)
  end

  def call
    ActiveRecord::Base.transaction do
      if @task.destroy
        broadcast(:task_destroy_success, true)
      else
        broadcast(:task_destroy_failure, false)
        fail(ActiveRecord::Rollback)
      end
    end
  end

end