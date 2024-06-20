# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
10.times do
  Task.create(
    name: Faker::Artist.name,
    description: Faker::Movies::HarryPotter.quote,
    status: Faker::Movies::HarryPotter.spell,
    creator: Faker::Name.name,
    performer: Faker::Name.name,
    completed: Faker::Boolean.boolean
  )
end
