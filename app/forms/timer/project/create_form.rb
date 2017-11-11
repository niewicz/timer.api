module Timer::Project

  CreateForm = Dry::Validation::Schema(Timer::BaseForm) do
    # TODO validate title uniqueness
    required(:title).filled(:str?)

    optional(:description).filled(:str?)
    optional(:client_id).filled(:int?)
  end

end