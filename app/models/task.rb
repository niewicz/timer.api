class Task < ApplicationRecord
  belongs_to :user
  belongs_to :client
  belongs_to :project, optional: true

  has_many :time_entries

  def total_time
    if time_entries
      time_entries.reduce { |sum, te| sum + te.total_time }
    else
      0
    end
  end

end