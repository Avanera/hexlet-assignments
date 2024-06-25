# frozen_string_literal: true

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
