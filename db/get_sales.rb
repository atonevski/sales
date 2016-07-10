require 'nokogiri'
require 'bigdecimal'

doc = File.read('2016-07-06.xml')

puts "File size: #{ doc.size }"

doc = Nokogiri::XML doc

puts "Total records: #{ doc.xpath('//flows/r').size }"

count = 0
arr = [ ]
doc.xpath('//flows/r').each do |r|
  next if r['u'] == '0.00' and r['i'] == '0.00'
  count += 1
  
  terminal_id = r['uid'].to_i
  agent_id    = r['aid'].to_i
  d           = r['d']

  r.xpath('.//gx/g').each do |g|
    next if g['u'] == '0.00' and g['i'] == '0.00' 
      arr << {
        date:         d,
        terminal_id:  terminal_id,
        agent_id:     agent_id,
        game_id:      g['id'].to_i,
        sales:        g['u'],
        payout:       g['i'],
      }
  end
end
puts "Found #{ count } non-null records"
puts "Sales records total: #{ arr.size }"

total = { }
arr.each do |h|
  total[h[:game_id]] ||= { sales: BigDecimal.new(0), payout: BigDecimal.new(0) }
  total[h[:game_id]][:sales]  += BigDecimal.new h[:sales]
  total[h[:game_id]][:payout] += BigDecimal.new h[:payout]
end

total.each do |g, s|
  printf "%2d %10.0f %10.0f\n", g, s[:sales], s[:payout]
end
