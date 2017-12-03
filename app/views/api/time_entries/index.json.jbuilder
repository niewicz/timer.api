json.time_entries do
  json.partial! 'api/time_entries/time_entry', collection: @time_entries, as: :time_entry
end