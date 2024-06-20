class Task < ApplicationRecord
  validates :name, :status, :creator, :completed, presence: true

  attribute :status, :string, default: -> { 'new' }
  attribute :completed, :string, default: -> { false }
end
