if task.present?
  json.(task,
    :id,
    :title,
    :price)
  
  json.project do
    json.partial! 'api/projects/project_simple', project: task.project
  end
else
  json.nil!
end