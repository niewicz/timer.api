json.time_entries do
  json.array! @grouped_time_entries do |k, v|
    json.date k
    json.time_entries do
      json.partial! 'api/time_entries/time_entry', collection: v, as: :time_entry
    end
  end
end
json.total @total