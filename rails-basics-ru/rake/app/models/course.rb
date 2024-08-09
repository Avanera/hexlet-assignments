# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :courses_users, dependent: :destroy
  has_many :users, through: :courses_users
end
