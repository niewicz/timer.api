class TimeEntry < ApplicationRecord
  self.table_name = 'time_entries'.freeze

  belongs_to :task, optional: true
  belongs_to :user

  def day_of_entry
    start_at.to_date.to_s
  end

  def total_time
    end_at - start_at
  end

  def to_pay 
    if task && task.price
      return ((total_time / 3600) * task.price).round(2)
    end
    0
  end
end