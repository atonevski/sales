require 'yaml'
require 'sqlite3'

unless ARGV[0] =~ /^\d{4}-\d\d-\d\d$/
  raise "syntax: sal-uptodate yyyy-mm-dd\n\targ: start date"
end

# DB dsales
DB = File.expand_path('/home/and/Scripts/Ruby/dsales/db/dsales.db')
db = SQLite3::Database.new DB
db.execute('PRAGMA foreign_keys=ON');
unless 1 == db.get_first_value('PRAGMA foreign_keys').to_i
  raise "Can't set foreign keys pragma!" 
end
db.results_as_hash = true

a = [ ]
qry =<<-EOT
  SELECT
    s.date        AS date,
    s.terminal_id AS terminal_id,
    t.agent_id    AS agent_id,
    s.game_id     AS game_id,
    s.sales       AS sales,
    s.payout      AS payout
  FROM
    sales AS s
    INNER JOIN terminals AS t
      ON s.terminal_id = t.id
  WHERE
    s.date >= '#{ ARGV[0] }'
EOT

db.execute(qry).each do |r|
  a << {
    date:         r['date'],
    terminal_id:  r['terminal_id'],
    agent_id:     r['agent_id'],
    game_id:      r['game_id'],
    sales:        r['sales'],
    payout:       r['payout']
  }
end
puts a.to_yaml
