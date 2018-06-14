module Timer::User

  SetTimezoneForm = Dry::Validation::Schema(Timer::BaseForm) do
    required(:timezone).filled(:str?)
  end

end