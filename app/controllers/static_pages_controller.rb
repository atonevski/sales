class StaticPagesController < ApplicationController
  skip_after_action :verify_authorized, :verify_policy_scoped

  def about
    # empty for now
  end

  def todo
    # my todo list/log 
    
    ##
    # use this code to list available sales
    last_date = Sale.maximum(:date).strftime '%Y-%m-%d'

    begin
      @available_sales = get_available_sales.select {|a| a[:date] > last_date}
    rescue => e
      Rails.logger.info "Got this exception while reading available sales files: " +
        "\033[31m#{ e }\033[0m"
    end

    ##
    # insert this in todo.html.erb
    # <div class='table-responsive'>
    #   <table class='table table-striped table-condensed table-hover'>
    #     <thead>
    #       <tr>
    #         <th>Date</th>
    #         <th>Size</th>
    #         <th>Time</th>
    #       </tr>
    #     </thead>
    #     <tbody>
    #       <% @available_sales.each do |s| %>
    #         <tr>
    #           <td><%= s[:date] %></td>
    #           <td><%= s[:size] %></td>
    #           <td><%= s[:time] %></td>
    #         </tr>
    #       <% end %>
    #     </tbody>
    #   </table>
    # </div>
  end

  def terminals
    # first we must have a saved xml file into our local yaml file
    # h = parse_terminals_xml File.read(Rails.root + 'db/UmDlm.xml')
    # File.open(Rails.root + 'db/terminals.yml', 'w') { |f| f.write h.to_yaml }
    
    # read xml-terminals yaml file
    h = YAML::load File.open(Rails.root + 'db/terminals.yml')

    # if our yaml file is obsolete
    xh = nil
    if Date.parse(h[:date]) < Date.today
      begin
        text = get_terminals_xml
        xh = parse_terminals_xml text
        File.open(Rails.root + 'db/terminals.yml', 'w') { |f| f.write xh.to_yaml }
      rescue  => e
        Rails.logger.info "Got this exception for reading terminals xml file: " +
          "\033[31m#{ e }\033[0m"
      end
    end

    @terminals = xh ? xh : h
  end

private
  XML_PATH = "http://10.211.102.100:8080/DANCE/4WEB/"

  def get_available_sales
    uri = URI.parse(XML_PATH)
    http = Net::HTTP.new uri.host, uri.port
    http.open_timeout = 3
    http.read_timeout = 3
    req = Net::HTTP::Get.new uri.request_uri
    res = http.request req

    raise "Got error: #{ res.code }" if res.code != '200'

    uri = URI.parse(XML_PATH)
    res = Net::HTTP.get_response(uri)

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

  def get_terminals_xml
    uri = URI.parse(XML_PATH + 'UmDlm.xml')
    http = Net::HTTP.new uri.host, uri.port
    http.open_timeout = 5
    http.read_timeout = 5
    req = Net::HTTP::Get.new uri.request_uri
    res = http.request req

    # return nil if res.code != '200'
    raise "Got error: #{ res.code }" if res.code != '200'

    res.body.force_encoding('utf-8')
  end

  def parse_terminals_xml(text)
    doc = Nokogiri::HTML text
   
    h = { }
    a = [ ]
    h[:date] = doc.xpath('//um')[0].attr('d');
    doc.xpath('//u').each do |r|
      a << {
        agent_id:     r.attr('aid'),
        agent_name:   r.attr('an'),
        id:           r.attr('uid'),
        name:         r.attr('un'),
        city:         r.attr('m'),
        address:      r.attr('a'),
        tel:          r.attr('t'),
        status:       r.attr('s')
      }
    end

    h[:terminals] = a
    h
  end
end
