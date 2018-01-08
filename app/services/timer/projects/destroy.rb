class Timer::Projects::Destroy < Timer::BaseService
  include Wisper::Publisher
  
  def initialize(project)
    @project = project.presence || fail(ArgumentError)
  end

  def call
    ActiveRecord::Base.transaction do
      if @project.destroy
        broadcast(:project_destroy_success, true)
      else
        broadcast(:project_destroy_failure, false)
        fail(ActiveRecord::Rollback)
      end
    end
  end

end