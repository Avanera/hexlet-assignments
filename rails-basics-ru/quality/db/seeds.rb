# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
10.times do |index|
  bulletin_index = index + 1
  Bulletin.create(
    title: "Title #{bulletin_index}",
    body: "This bulletin is about Title #{bulletin_index}"
  )
end
