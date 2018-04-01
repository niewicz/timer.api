if project.present?
  json.(project,
    :id,
    :title)

  json.total_tracked project.total_time

  json.client do
    json.partial! 'api/clients/client_simple', client: project.client
  end
else
  json.nil!
end