class StaticPagesController < ApplicationController
  skip_after_action :verify_authorized, :verify_policy_scoped

  def about
    # empty for now
  end
  def todo
    # my todo list/log 
    # @available_sales = get_available_sales
    @terminals_xml = File.read Rails.root + 'db/UmDlm.xml'
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
  # def parse_terminals_xml(text)
  #   doc = Nokogiri::HTML text
  #  
  #   h = { }
  #   a = [ ]
  #   h[:date] = doc.xpath('//um')[0].attr('d');
  #   doc.xpath('//u').each do |r|
  #     a << {
  #       agent_id:     r.attr('aid'),
  #       agent_name:   r.attr('an'),
  #       id:           r.attr('uid'),
  #       name:         r.attr('un'),
  #       city:         r.attr('m'),
  #       address:      r.attr('a'),
  #       tel:          r.attr('t'),
  #       status:       r.attr('s')
  #     }
  #   end

  #   h[:terminals] = a
  #   h
  # end
end
