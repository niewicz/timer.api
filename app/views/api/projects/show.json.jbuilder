json.project do
  if @project.present?
    json.(@project,
      :id,
      :title,
      :description)
  
    json.task_counter @project.tasks.count

    json.client do
      json.partial! 'api/clients/client_simple', client: @project.client
    end

    json.tasks do
      json.partial! 'api/tasks/task_for_project', collection: @project.tasks, as: :task
    end
  else
    json.nil!
  end
end