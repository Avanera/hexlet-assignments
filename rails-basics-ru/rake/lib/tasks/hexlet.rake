# frozen_string_literal: true

require 'csv'

# bin/rails "hexlet:import_users[test/fixtures/files/users.csv]"
namespace :hexlet do
  desc 'Creates 100 users from scv file'
  task :import_users, [:file] => :environment do |_t, args|
    print "Task started\n"
    users = CSV.read(args[:file], headers: true)
    users.each do |u|
      u['birthday'] = Date.strptime(u['birthday'], '%m/%d/%Y')
      User.create!(u)
      print '.'
    end
    print "Done!\n"
  end
end
