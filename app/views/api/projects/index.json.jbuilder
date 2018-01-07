json.projects do
  json.partial! 'api/projects/project_simple', collection: @projects, as: :project
end
json.total @total