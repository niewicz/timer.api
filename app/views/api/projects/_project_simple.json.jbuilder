if project.present?
  json.(project,
    :id,
    :title)

  json.task_counter project.tasks.count
  json.total_tracked project.total_time
else
  json.nil!
end