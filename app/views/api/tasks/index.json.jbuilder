json.tasks do
  json.partial! 'api/tasks/task_simple', collection: @tasks, as: :task
end