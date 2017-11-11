module Timer::Task
  
  UpdateForm = Dry::Validation::Schema(Timer::BaseForm) do
    require(:id).filled(:int?)
    # TODO validate title uniqueness
    require(:title).filled(:str?)

    optional(:price).filled(:int?)
    optional(:data).filled
    optional(:project_id).filled(:int?)
    optional(:client_id).filled(:int?)
  end

end