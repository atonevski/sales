namespace :db do
  desc 'Purge games table'
  task :purge_games => :environment do
    if Game.count > 0
      puts "There are somme records in Games table"
      print "Purge Games? (y/n) "
      y_n = STDIN.gets.chomp.upcase[0]
      if y_n == 'Y'
        Category.delete_all
        Game.delete_all
      end
      next
    end
    puts "Games table is empty. Nothing to purge."
  end
  
  desc 'Populate games table'
  task init_games: [:environment, :purge_games] do
    next if Game.count > 0 or Category.count > 0
    h = YAML::load File.open(Rails.root + 'db/init_db.yml')
    inst_cat = YAML::load File.open(Rails.root + 'db/inst_cat.yml')
    h[:games].each do |g|
      Game.create g
      cat = inst_cat.find { |x| x[:id] == g[:id] }
      next unless cat
      cat[:categories].each do |c|
        Category.create c.merge(game_id: g[:id])
      end
    end
  end
end
