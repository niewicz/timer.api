json.projects do
  json.partial! 'api/projects/project_simple_2', collection: @projects, as: :project
end