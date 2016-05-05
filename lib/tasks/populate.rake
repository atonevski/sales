namespace :db do
  desc 'Purge games table'
  task :purge_games => :environment do
    if Game.count > 0
      puts "There are somme records in Games table"
      print "Purge Games? (y/n) "
      y_n = STDIN.gets.chomp.upcase[0]
      if y_n == 'Y'
        Game.delete_all
      end
      next
    end
    puts "Games table is empty. Nothing to purge."
  end
  
  desc 'Populate games table'
  task init_games: [:environment, :purge_games] do
    next if Game.count > 0
    h = YAML::load File.open(Rails.root + 'db/init_db.yml')
    h[:games].each do |g|
      Game.create g
    end
  end
end
