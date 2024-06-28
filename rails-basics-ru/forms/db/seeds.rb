# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
10.times do |index|
  post_index = index + 1
  Post.create(
    title: "Title #{post_index}",
    body: "Body #{post_index}",
    summary: "Summary #{post_index}",
    published: false
  )
end
