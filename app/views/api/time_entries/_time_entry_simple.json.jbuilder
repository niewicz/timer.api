if time_entry.present?
  json.(time_entry,
    :id,
    :task_id,
    :start_at,
    :end_at)
else
  json.nil!
end