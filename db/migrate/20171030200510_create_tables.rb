class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.belongs_to :user,     index: true
      t.string :name,         index: true,  null: false
      t.string :email
      t.string :contact_person_name
      t.string :contact_person_email

      t.timestamps
    end

    create_table :projects do |t|
      t.belongs_to :user,     index: true
      t.belongs_to :client,   index: true
      t.string :title,        null: false
      t.text :describtion

      t.timestamps
    end

    create_table :tasks do |t|
      t.belongs_to :project,  index: true
      t.belongs_to :user,     index: true
      t.belongs_to :client,   index: true
      t.string :title
      t.float :price
      t.json :data

      t.timestamps
    end

    create_table :time_entries do |t|
      t.belongs_to :task,     index: true
      t.datetime :start_at,   null: false
      t.datetime :end_at

      t.timestamps
    end
  end
end
