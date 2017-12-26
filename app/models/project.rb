class Project < ApplicationRecord
  belongs_to :user
  belongs_to :client, optional: true

  has_many :tasks
  has_many :time_entries

  def unassigned_time_entries
    this.time_entries.where('task_id is null')
  end
end
