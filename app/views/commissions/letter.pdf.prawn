prawn_document(page_size: 'A4') do |pdf|
  img_width = (72*180/25.4).round
  img_height = (72*32/25.4).round

  droid = "#{Prawn::BASEDIR}/data/fonts/DroidSans.ttf"
  droid_bold ="#{Prawn::BASEDIR}/data/fonts/DroidSans-Bold.ttf"
  
  pdf.font_families.update('droid' => {
      normal: droid,
      bold:   droid_bold,
  })

  # calc commission
  total_commissions = 0
  @terminals.each do |t|
    sales = terminal_sales_for_period(t.id)
    total_commissions += sales.inject(0) {|t, s| t + s.game_sales*s.perc}
  end

  # logo
  pdf.image Rails.root + 'app/assets/images/logo.png',
            width:  img_width,
            height: img_height 

  # attn etc
  pdf.move_down img_height
  pdf.font 'droid'

  data = [[
    { content: "До\nСектор за финансии", font_style: :bold },
    '',
    "Архивски број:\nДата: #{ Date.today.strftime '%d.%m.%Y' }\nВрска:"
  ]]

  pdf.table data, width: img_width, cell_style: { borders: [], width: img_width/3, padding: 20 }

  # subject
  pdf.move_down 40
  pdf.text "Предмет: Исплата на провизија од игри на среќа по фактура: #{ @invoice_id }"+
           " од #{ @invoice_date } од #{ @agent.name }" , style: :bold
  
  pdf.text "\n\nСогласно договорот за деловна соработка од страна на деловниот " +
           "соработник #{ @agent.name }, доставени се фактури за исплата на провизија" +
           " од игри на среќа и тоа:\n\n"

  data = [[
    '•',
    { 
      content: "Фактура бр. #{ @invoice_id } од #{ @agent.name } на сума од <b>" +
        (
          @invoiced_correctly == 'yes' ? number_with_precision(total_commissions, precision: 2, delimiter: ',', separator: '.') :
            @invoice_sum
        ) + "</b>",
      inline_format: true,

    }
  ]]
  pdf.table data, width: img_width, cell_style: { borders: [] }, column_widths: [20, img_width - 20]

  if @invoiced_correctly == 'yes'
    pdf.text "\n\nПодатоците се точно пресметани во согласност со продажбата на " +
             "#{ @agent.name } во горенаведениот период.\n\n\n\n"
  else
    pdf.text "\n\nПодатоците <u>не се точно</u> пресметани во согласност со продажбата на " +
             "#{ @agent.name } во горенаведениот период. " +
             "Точниот износ кој треба да стои е: <b>" +
             "#{ number_with_precision(total_commissions, precision: 2, delimiter: ',', separator: '.') }</b> " +
             "денари.\n\n\n\n",
             inline_format: true
  end

  data = [[
    "Одобрил:\nДиректор на Сектор за финансии\n\n\nДаница Димовска",
    {
      content:
        "Контролирал:\n\n\n" +
        "Андреја Тоневски\n\n\n\n\n" +
        "Директор на Сектор за продажба и комерција\n\n\n" +
        "Ивица Младеновски",
      align: :right,
    }
  ]]

  pdf.table data, width: img_width, cell_style: { borders: [], padding: 20 }
end
