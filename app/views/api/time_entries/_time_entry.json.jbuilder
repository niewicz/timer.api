if time_entry.present?
  json.(time_entry,
    :id,
    :task_id,
    :start_at,
    :end_at)

  presenter = ::Timer::TimeEntryPresenter.new(time_entry)

  json.task do
    json.partial! 'api/tasks/task', task: presenter.task
  end

  json.project do
    json.partial! 'api/projects/project', project: presenter.project
  end

  json.client do
    json.partial! 'api/clients/client_simple', client: presenter.client
  end
else
  json.nil!
end