module Timer::TimeEntry

  CreateForm = Dry::Validation::Schema(Timer::BaseForm) do
    required(:start_at).filled(:time?)

    optional(:end_at).maybe(:time?)
    optional(:task_id).maybe(:int?)
  end

end