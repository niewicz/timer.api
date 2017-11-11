module Timer::TimeEntry

  CreateForm = Dry::Validation::Schema(Timer::BaseForm) do
    required(:start_at).filled(:date_time?)

    optional(:end_at).maybe(:date_time?)
    optional(:task_id).maybe(:int?)
  end

end