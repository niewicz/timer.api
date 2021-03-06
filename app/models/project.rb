class Project < ApplicationRecord
  belongs_to :user
  belongs_to :client, optional: true

  has_many :tasks
  has_many :time_entries, through: :tasks

  def total_time
    self.tasks.map{ |t| t.total_time }.reduce(:+) rescue 0
  end
end
