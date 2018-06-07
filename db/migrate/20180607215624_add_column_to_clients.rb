class AddColumnToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :auto_send, :boolean, default: :false
  end
end
