if client.present?
  json.(client,
    :id,
    :name,
    :email,
    :contact_person_name,
    :Contact_person_email)
else
  json.nil!
end