class Course < ApplicationRecord
  has_many :lessons
  has_many :courses_users
  has_many :users, through: :courses_users
end
