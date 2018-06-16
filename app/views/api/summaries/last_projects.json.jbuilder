json.projects do
  json.partial! 'api/projects/project', collection: @projects, as: :project
end