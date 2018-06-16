if project.present?
  json.(project,
    :id,
    :title,
    :description)

  json.task_counter project.tasks.count
  json.total_tracked project.total_time
  json.last_task project.tasks.last

  json.client do
    json.partial! 'api/clients/client_simple', client: project.client
  end
else
  json.nil!
end