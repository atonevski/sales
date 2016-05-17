# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Users: create me as admin
unless User.exists? email: 'atonevski@gmail.com'
  User.create! email: 'atonevski@gmail.com', password: 'salesok', admin: true
end
