json.clients do
  json.partial! 'api/clients/client_simple', collection: @clients, as: :client
end
json.total @total