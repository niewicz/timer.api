class Task < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  belongs_to :project, optional: true

  has_many :time_entries

  def total_time
    total = 0
    self.time_entries.where('end_at is not null').each do |te|
      total += te.end_at - te.start_at
    end
    total
  end
end