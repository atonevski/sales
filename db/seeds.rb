# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Users: create me as admin, viewer, editor and manager
unless User.exists? email: 'atonevski@gmail.com'
  User.create! email: 'atonevski@gmail.com', password: 'salesok', admin: true
end
unless User.exists? email: 'viewer@example.com'
  User.create! email: 'viewer@example.com', password: 'viewerok'
end
unless User.exists? email: 'editor@example.com'
  User.create! email: 'editor@example.com', password: 'editorok'
end
unless User.exists? email: 'manager@example.com'
  User.create! email: 'manager@example.com', password: 'managerok'
end
puts 'Inserted some users'

# basic roles for default users
unless Role.exists? user_id: 2, role: :viewer
  Role.create! user_id: 2, role: :viewer, model: 'Game'
end
unless Role.exists? user_id: 3, role: :editor
  Role.create! user_id: 3, role: :editor, model: 'Game'
end
unless Role.exists? user_id: 4, role: :manager
  Role.create! user_id: 4, role: :manager, model: 'Game'
end
puts 'Created some roles for the users'

puts 'Inserting agent and terminals'
Rake::Task['db:init_agents'].invoke

puts 'Inserting games and categories'
Rake::Task['db:init_games'].invoke
