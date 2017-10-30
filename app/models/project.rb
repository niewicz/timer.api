class Project < ApplicationRecord
  belongs_to :user
  belongs_to :client

  has_many :tasks
end
