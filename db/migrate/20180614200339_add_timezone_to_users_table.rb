class AddTimezoneToUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :timezone, :string, default: 'UTC'
  end
end
