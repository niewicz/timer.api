module Timer::Project

  CreateForm = Dry::Validation::Schema(Timer::BaseForm) do
    # TODO validate title uniqueness
    required(:title).filled(:str?)

    optional(:description).maybe(:str?)
    optional(:client_id).maybe(:int?)
  end

end