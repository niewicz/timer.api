class Timer::Projects::Update < Timer::BaseService
  include Wisper::Publisher
  
  def initialize(project, params)
    @project = project.presence || fail(ArgumentError)
    @params = params.presence || fail(ArgumentError)
  end

  def call
    ActiveRecord::Base.transaction do
      @project.assign_attributes(@params)
      errors = ::Timer::Project::UpdateForm.call(@project.attributes).messages

      if errors.none? && @project.save(validate: false)
        broadcast(:project_create_success, @project)
      else
        broadcast(:project_create_failure, errors)
        fail(ActiveRecord::Rollback)
      end
    end
  end

end