if client.present?
  json.(client,
    :id,
    :name,
    :email,
    :contact_person_name,
    :contact_person_email,
    :auto_send)

  json.projects do
    json.partial! 'api/projects/project_simple', collection: client.projects, as: :project
  end
else
  json.nil!
end