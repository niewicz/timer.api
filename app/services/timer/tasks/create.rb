class Timer::Tasks::Create < Timer::BaseService
  include Wisper::Publisher

  def initialize(user, params)
    @user = user.presence || fail(ArgumentError)
    @params = params.presence || fail(ArgumentError)
  end

  def call
    ActiveRecord::Base.transaction do
      task = @user.tasks.new(@params)
      errors = ::Timer::Task::CreateForm.call(task.attributes)

      if errors.none? && task.save(validate: false)
        broadcast(:task_create_success, task)
      else
        broadcast(:task_create_failure, errors)
        fail(ActiveRecord::Rollback)
      end
    end
  end

end