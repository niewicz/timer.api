if project.present?
  json.(project,
    :id,
    :title,
    :description)

  json.client do
    json.partial! 'api/clients/client_simple', client: project.client
  end
else
  json.nil!
end