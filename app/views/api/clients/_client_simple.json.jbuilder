if client.present?
  json.(client,
    :id,
    :name,
    :email)
else
  json.nil!
end