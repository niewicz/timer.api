if project.present?
  json.(project,
    :id,
    :title,
    :description)
else
  json.nil!
end