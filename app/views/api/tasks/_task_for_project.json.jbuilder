if task.present?
  json.(task,
    :id,
    :title,
    :price,
    :project_id,
    :total_time
  )

  json.time_entries do
    json.partial! 'api/time_entries/time_entry_simple', collection: task.time_entries, as: :time_entry
  end
else
  json.nil!
end