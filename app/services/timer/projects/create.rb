class Timer::Projects::Create < Timer::BaseService
  include Wisper::Publisher

  def initialize(user, params)
    @user = user.presence || fail(ArgumentError)
    @params = params.presence || fail(ArgumentError)
  end

  def call
    ActiveRecord::Base.transaction do
      project = @user.projects.new(@params)
      errors = ::Timer::Project::CreateForm.call(project.attributes).messages

      if errors.none? && project.save(validate: false)
        broadcast(:project_create_success, project)
      else
        broadcast(:project_create_failure, errors)
        fail(ActiveRecord::Rollback)
      end
    end
  end

end