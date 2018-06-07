if client.present?
  json.(client,
    :id,
    :name,
    :email,
    :contact_person_name,
    :contact_person_email,
    :auto_send)
else
  json.nil!
end