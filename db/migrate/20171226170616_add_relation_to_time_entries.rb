class AddRelationToTimeEntries < ActiveRecord::Migration[5.1]
  def change
    add_reference :time_entries, :project
  end
end
