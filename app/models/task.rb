class Task < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  belongs_to :project

  has_many :time_entries
end