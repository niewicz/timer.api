module Timer::Task
  
  CreateForm = Dry::Validation::Schema(Timer::BaseForm) do
    # TODO validate title uniqueness
    required(:title).filled(:str?)

    optional(:price).maybe(:int?)
    optional(:data).maybe
    optional(:project_id).maybe(:int?)
    optional(:client_id).maybe(:int?)
  end

end