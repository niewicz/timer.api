if task.present?
  json.(task,
    :id,
    :title,
    :price)
else
  json.nil!
end