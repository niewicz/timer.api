class TimeEntry < ApplicationRecord
  self.table_name = 'time_entries'.freeze

  belongs_to :task
end