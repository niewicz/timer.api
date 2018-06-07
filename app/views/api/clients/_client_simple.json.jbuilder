if client.present?
  json.(client,
    :id,
    :name,
    :email,
    :contact_person_name,
    :contact_person_email,
    :auto_send)
  json.projects_counter client.projects.count
  json.last_project client.projects.last
else
  json.nil!
end