module Timer::User::BillingProfile

  DefaultForm = Dry::Validation::Schema(Timer::BaseForm) do
    required(:email).filled(:str?)
    required(:person_name).filled(:str?)

    optional(:company_name).maybe(:str?)
    optional(:phone).maybe(:str?)
    optional(:address).maybe(:str?)
    optional(:city).maybe(:str?)
    optional(:postal_code).maybe(:str?)
    optional(:country).maybe(:str?)
    optional(:account_owner).maybe(:str?)
    optional(:iban).maybe(:str?)
    optional(:swift_code).maybe(:str?)
    optional(:currency).maybe(:str?)
  end

end