class StaticPagesController < ApplicationController
  def about
    # empty for now
  end
  def todo
    # my todo list/log 
    @available_sales = get_available_sales
  end

private
  XML_PATH = "http://10.211.102.100:8080/DANCE/4WEB/"
  def get_available_sales
    uri = URI.parse(XML_PATH)
    res = Net::HTTP.get_response(uri)
    unless res.code == '200'
      puts "ERROR reading #{ uri.path }"
      puts "Got: #{res.code} code, exiting"
      exit 1
    end
    doc = Nokogiri::HTML res.body.force_encoding('utf-8')

    a = [ ]
    doc.xpath('//table/tr').each do |tr|
      tt = tr.xpath('.//td//tt')
      next unless tt.length == 3
      next unless tt[0].text =~ /^(\d{4}-\d\d-\d\d)/
      date = Regexp.last_match[1]
      a << {
        date: date,
        size: tt[1].text,
        time: tt[2].text
      }
    end

    a
  end
end
