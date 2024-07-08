# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, foreign_key: 'creator_id'

  validates :birthday, :first_name, :last_name, :email, presence: true
end
