module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        'Sales - ' + parts.join(' - ')
      end
    end
  end

  def admins_only(&block)
    block.call if current_user.try(:admin?)
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
