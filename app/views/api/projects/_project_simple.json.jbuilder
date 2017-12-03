if project.present?
  json.(project,
    :id,
    :description)
else
  json.nil!
end