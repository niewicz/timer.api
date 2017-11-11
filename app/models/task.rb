class Task < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  belongs_to :project, optional: true

  has_many :time_entries
end