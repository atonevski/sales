# require 'activerecord-import'

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

  desc 'Purge agents table'
  task :purge_agents => :environment do
    if Agent.count > 0
      puts "There are somme records in Agents table"
      print "Purge Agents? (y/n) "
      y_n = STDIN.gets.chomp.upcase[0]
      if y_n == 'Y'
        Terminal.delete_all
        Agent.delete_all
      end
      next
    end
    puts "Agents table is empty. Nothing to purge."
  end

  desc 'Populate agents table'
  task init_agents: [:environment, :purge_agents] do
    next if Agent.count > 0 # or Category.count > 0 # should be Terminal.count
    h = YAML::load File.open(Rails.root + 'db/init_db.yml')
    h[:agents].each do |a|
      Agent.create a
    end
    h[:terminals].each do |t|
      Terminal.create t
    end
   
  end

  desc 'Purge sales table'
  task :purge_sales => :environment do
    if Sale.count > 0
      puts "There are somme records in Sales table"
      print "Purge Sales? (y/n) "
      y_n = STDIN.gets.chomp.upcase[0]
      if y_n == 'Y'
        Sale.delete_all
      end
      next
    end
    puts "Sales table is empty. Nothing to purge."
  end

  desc 'Populate sales table'
  task init_sales: [:environment, :purge_sales] do
    next if Sale.count > 0 

    %W{2010 2011 2012 2013 2014 2015}.each do |year|
      yaml_file = year == '2015' ? 'db/sales-2015-.yaml' : "db/sales-#{year}.yaml"
      a = YAML::load File.open(Rails.root + yaml_file)
      puts "Importing #{ year }"
      # a.each do |rec|
      #   Sale.create rec
      # end

      puts "creating sa..."
      sa = [ ]
      a.each { |r| sa << Sale.new(r) }
      puts "importing from sa..."
      Sale.import sa
    end
  end
end
