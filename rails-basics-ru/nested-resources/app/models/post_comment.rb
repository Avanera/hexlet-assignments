# frozen_string_literal: true

class PostComment < ApplicationRecord
  validates :body, presence: true

  belongs_to :post
end
