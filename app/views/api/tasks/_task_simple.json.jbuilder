if task.present?
  json.(task,
    :id,
    :title,
    :price,
    :project_id)
  
  json.project do
    json.partial! 'api/projects/project_simple', project: task.project
  end
else
  json.nil!
end