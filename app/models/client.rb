class Client < ApplicationRecord
  belongs_to :user

  has_many :projects
  has_many :tasks, through: :projects
  has_many :time_entries, through: :tasks
end