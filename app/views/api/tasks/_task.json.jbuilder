if task.present?
  json.(task,
    :id,
    :title,
    :price,
    :project_id,
    :total_time
  )
  
  json.project do
    json.partial! 'api/projects/project', project: task.project
  end
else
  json.nil!
end