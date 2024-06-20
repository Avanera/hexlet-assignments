# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
10.times do
  Task.create(
    name: Faker::Lorem.sentence(word_count: rand(2..10)).chomp('.'),
    description: Faker::Lorem.words(number: rand(2..10)).join(' '),
    status: %w[new old].sample,
    creator: Faker::Name.name,
    performer: Faker::Name.name,
    completed: Faker::Boolean.boolean
  )
end
