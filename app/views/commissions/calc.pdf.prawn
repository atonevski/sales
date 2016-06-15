prawn_document(page_size: 'A4') do |pdf|
  droid = "#{Prawn::BASEDIR}/data/fonts/DroidSans.ttf"
  droid_bold ="#{Prawn::BASEDIR}/data/fonts/DroidSans-Bold.ttf"
  
  pdf.font_families.update('droid' => {
      normal: droid,
      bold:   droid_bold,
  })

  pdf.move_down 20
  pdf.font 'droid'
  pdf.text "#{ @agent.name } ##{ @agent.id }", size: 18, style: :bold
  pdf.move_down 20

  pdf.text "Commission for period " + format_period, size: 12, style: :bold

  pdf.font 'droid'
  pdf.font_size = 10

  total_sales = 0
  total_commissions = 0
  @terminals.each_with_index do |t, i|
    data = []
    data << ['Terminal', { content: 'ID', align: :center },
             { content: 'game', align: :center }, 
             { content: 'sales', align: :right },
             { content: '%', align: :center }, 
             { content: 'commission', align: :right }]

    sales = terminal_sales_for_period(t.id)
    data << [ {content: "#{ t.id } #{ t.name }", colspan: 6} ]
    sales.each do |s|
      data << [ { content: s.game_id.to_s, align: :right, colspan: 2 }, s.game_name,
                { content: number_to_currency(s.game_sales, precision: 2, unit: ''),
                  align: :right },
                { content: (s.perc*100).to_i.to_s + '%', align: :center },
                { content: number_to_currency(s.perc*s.game_sales, precision: 2, unit: ''),
                  align: :right } ]
    end
    # total
    total_sales += sales.inject(0) {|t, s| t + s.game_sales}
    total_commissions += sales.inject(0) {|t, s| t + s.game_sales*s.perc}

    data << [ { content: number_to_currency(sales.inject(0) {|t, s| t + s.game_sales},
                      precision: 2, unit: ''), align: :right, colspan: 4 },
              { content: number_to_currency(sales.inject(0) {|t, s| t + s.game_sales*s.perc},
                  precision: 2, unit: ''), align: :right, colspan: 2 } ]
    if i+1 == @terminals.length
      data << [ { content: number_to_currency(total_sales,
                        precision: 2, unit: ''), align: :right, colspan: 4 },
                { content: number_to_currency(total_commissions,
                    precision: 2, unit: ''), align: :right, colspan: 2 } ]
    end
    pdf.table data, width: 520 do |t|
      t.row(0).font_style = :bold
      t.row(sales.length + 2).font_style = :bold
      t.row(sales.length + 3).font_style = :bold if i+1 == @terminals.length
    end
    pdf.move_down 20
  end
end
