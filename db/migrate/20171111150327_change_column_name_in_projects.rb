class ChangeColumnNameInProjects < ActiveRecord::Migration[5.1]
  def change
    rename_column :projects, :describtion, :description
  end
end
