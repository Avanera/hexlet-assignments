# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, foreign_key: 'creator_id'
  has_many :courses_users, dependent: :destroy
  has_many :courses, through: :courses_users

  validates :birthday, :first_name, :last_name, :email, presence: true
end
