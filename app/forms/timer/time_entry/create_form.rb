module Timer::TimeEntry

  CreateForm = Dry::Validation::Schema(Timer::BaseForm) do
    require(:start_at).filled(:datetime?)

    optional(:end_at).maybe(:datetime?)
    optional(:task_id).maybe(:int?)
  end

end