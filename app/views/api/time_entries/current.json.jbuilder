json.time_entry do
  json.partial! 'api/time_entries/time_entry', time_entry: @time_entry
end