class CommissionsController < ApplicationController
  skip_after_action :verify_authorized, :verify_policy_scoped
  helper_method :format_period, :terminal_sales_for_period

  # 1st we handle the period
  MONTH_NAMES_EN = ['', 'January', 'February', 'March', 'April', 'May', 'June', 'July',
                    'August', 'September', 'October', 'November', 'December']
  MONTH_NAMES_MK = ['', 'јануари', 'февруари', 'март', 'април', 'мај', 'јуни', 'јули',
                    'август', 'септември', 'октомври', 'ноември', 'декември']
  def index
  end

  def show
   @agent = Agent.find params[:id] 
   @terminals = @agent.terminals
   @months = Sale.distinct.select('substr(date, 1, 7) AS ym')
              .where(agent_id: 225).where('sales > 0.0').order('ym ASC')
  end

  def create
    @from     = params[:from]
    @to       = params[:to]
    @agent    = Agent.find params[:agent_id]
    terminal_ids = Sale.distinct.select(:terminal_id)
                    .where('substr(date, 1, 7) >= ?', @from)
                    .where('substr(date, 1, 7) <= ?', @to)
                    .where(agent_id: @agent.id)
                    .order(:terminal_id).to_a
                    .map {|r| r.terminal_id}
    @terminals = Terminal.find(terminal_ids)

    render 'calc'
  end

  def terminal_sales_for_period(terminal_id)
    sel =<<-EOT
      g.id          AS game_id,
      g.name        AS game_name,
      SUM(s.sales)  AS game_sales,
      g.commission  AS perc
    EOT
    Sale.select(sel)
        .joins('AS s INNER JOIN games AS g ON s.game_id = g.id')
        .where('s.terminal_id = ?', terminal_id)
        .where('substr(s.date, 1, 7) >= ?', @from)
        .where('substr(s.date, 1, 7) <= ?', @to)
        .group('g.id')
  end
  
  def format_period(lang = :en)
    if lang.to_s == 'mk'
      month_names = MONTH_NAMES_MK
    else
      month_names = MONTH_NAMES_EN
    end

    if @from[0..3] == @to[0..3]
      if @from[5..6] == @to[5..6]
        "#{ month_names[@from[5..6].to_i] } #{ @from[0..3] }"
      else
        "#{ month_names[@from[5..6].to_i] } -- #{ month_names[@to[5..6].to_i] }" +
          " #{ @from[0..3] }"
      end
    else
      "#{ month_names[@from[5..6].to_i] } #{ @from[0..3] } -- " +
      "#{ month_names[@to[5..6].to_i] } #{ @to[0..3] }"
    end
  end
end
