class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :clients
  has_many :projects
  has_many :tasks
  has_many :time_entries

  has_one :billing_profile
end
