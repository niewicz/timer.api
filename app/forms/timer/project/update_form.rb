module Timer::Project
  
  UpdateForm = Dry::Validation::Schema(Timer::BaseForm) do
    require(:id).filled(:int?)
    # TODO validate title uniqueness
    require(:title).filled(:str?)

    optional(:description).filled(:str?)
    optional(:client_id).filled(:int?)
  end

end