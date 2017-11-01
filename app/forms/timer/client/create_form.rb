module Timer::Client

  CreateForm = Dry::Validation::Schema(Timer::BaseForm) do
    # TODO validate name uniqueness
    required(:name).filled(:str?)

    optional(:email).maybe(:str?)
    optional(:contact_person_name).maybe(:str?)
    optional(:contact_person_email).maybe(:str?)
  end

end
