# frozen_string_literal: true

class ResumeWork < ApplicationRecord
  validates :company, presence: true
  validates :begin_date, presence: true

  belongs_to :resume
end
