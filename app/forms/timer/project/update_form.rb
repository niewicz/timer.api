module Timer::Project
  
  UpdateForm = Dry::Validation::Schema(Timer::BaseForm) do
    required(:id).filled(:int?)
    # TODO validate title uniqueness
    required(:title).filled(:str?)

    optional(:description).maybe(:str?)
    optional(:client_id).maybe(:int?)
  end

end