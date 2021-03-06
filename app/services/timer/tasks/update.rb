class Timer::Tasks::Update < Timer::BaseService
  include Wisper::Publisher
  
  def initialize(task, params)
    @task= task.presence || fail(ArgumentError)
    @params = params.presence || fail(ArgumentError)
  end

  def call
    ActiveRecord::Base.transaction do
      @task.assign_attributes(@params)
      errors = ::Timer::Task::UpdateForm.call(@task.attributes).messages

      if errors.none? && @task.save(validate: false)
        broadcast(:task_update_success, @task)
      else
        broadcast(:task_update_failure, errors)
        fail(ActiveRecord::Rollback)
      end
    end
  end

end