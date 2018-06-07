module Timer::Client
  
  UpdateForm = Dry::Validation::Schema(Timer::BaseForm) do
    required(:id).filled(:int?)
    # TODO validate name uniqueness
    required(:name).filled(:str?)

    optional(:email).maybe(:str?)
    optional(:contact_person_name).maybe(:str?)
    optional(:contact_person_email).maybe(:str?)
    optional(:auto_send).maybe(:bool?)
  end
  
end