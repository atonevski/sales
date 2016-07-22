class ReportsController < ApplicationController

  skip_after_action :verify_authorized, :verify_policy_scoped
  helper_method :month_diff

  YMD = '%Y-%m-%d'

  ##
  # all games
  def annually_per_month_per_game
    @first_year = Sale.minimum(:date).year
    @last_year  = Sale.maximum(:date).year

    @year = params[:id] || @last_year

    qry =<<-EOT

      --
      -- SALES PER MONTH PER GAME
      --
      SELECT
        s.game_id         AS game_id,
        g.name            AS name,
        SUM(s.january)    AS january,
        SUM(s.february)   AS february,
        SUM(s.march)      AS march,
        SUM(s.april)      AS april,
        SUM(s.may)        AS may,
        SUM(s.june)       AS june,
        SUM(s.july)       AS july,
        SUM(s.august)     AS august,
        SUM(s.september)  AS september,
        SUM(s.october)    AS october,
        SUM(s.november)   AS november,
        SUM(s.december)   AS december
      FROM (
        SELECT
          game_id,
          CASE WHEN substr(date, 6, 2) = '01'THEN sales ELSE NULL END AS january,
          CASE WHEN substr(date, 6, 2) = '02'THEN sales ELSE NULL END AS february,
          CASE WHEN substr(date, 6, 2) = '03'THEN sales ELSE NULL END AS march,
          CASE WHEN substr(date, 6, 2) = '04'THEN sales ELSE NULL END AS april,
          CASE WHEN substr(date, 6, 2) = '05'THEN sales ELSE NULL END AS may,
          CASE WHEN substr(date, 6, 2) = '06'THEN sales ELSE NULL END AS june,
          CASE WHEN substr(date, 6, 2) = '07'THEN sales ELSE NULL END AS july,
          CASE WHEN substr(date, 6, 2) = '08'THEN sales ELSE NULL END AS august,
          CASE WHEN substr(date, 6, 2) = '09'THEN sales ELSE NULL END AS september,
          CASE WHEN substr(date, 6, 2) = '10'THEN sales ELSE NULL END AS october,
          CASE WHEN substr(date, 6, 2) = '11'THEN sales ELSE NULL END AS november,
          CASE WHEN substr(date, 6, 2) = '12'THEN sales ELSE NULL END AS december
        FROM
          sales
        WHERE
          date BETWEEN '#{ @year }-01-01' AND '#{ @year }-12-31'
          AND sales > 0.0
      ) AS s
        INNER JOIN games AS g
          ON s.game_id = g.id
      GROUP BY game_id
      ORDER BY game_id
    EOT
    @sales = ActiveRecord::Base.connection.execute qry

    # terminals
    qry =<<-EOT

      --
      -- ALL GAMES active terminals per month per game
      --
      SELECT
        s.game_id         AS game_id,
        g.name            AS name,
        COUNT(DISTINCT s.january)    AS january,
        COUNT(DISTINCT s.february)   AS february,
        COUNT(DISTINCT s.march)      AS march,
        COUNT(DISTINCT s.april)      AS april,
        COUNT(DISTINCT s.may)        AS may,
        COUNT(DISTINCT s.june)       AS june,
        COUNT(DISTINCT s.july)       AS july,
        COUNT(DISTINCT s.august)     AS august,
        COUNT(DISTINCT s.september)  AS september,
        COUNT(DISTINCT s.october)    AS october,
        COUNT(DISTINCT s.november)   AS november,
        COUNT(DISTINCT s.december)   AS december
      FROM (
        SELECT
          game_id,
          CASE WHEN substr(date, 6, 2) = '01'THEN terminal_id ELSE NULL END AS january,
          CASE WHEN substr(date, 6, 2) = '02'THEN terminal_id ELSE NULL END AS february,
          CASE WHEN substr(date, 6, 2) = '03'THEN terminal_id ELSE NULL END AS march,
          CASE WHEN substr(date, 6, 2) = '04'THEN terminal_id ELSE NULL END AS april,
          CASE WHEN substr(date, 6, 2) = '05'THEN terminal_id ELSE NULL END AS may,
          CASE WHEN substr(date, 6, 2) = '06'THEN terminal_id ELSE NULL END AS june,
          CASE WHEN substr(date, 6, 2) = '07'THEN terminal_id ELSE NULL END AS july,
          CASE WHEN substr(date, 6, 2) = '08'THEN terminal_id ELSE NULL END AS august,
          CASE WHEN substr(date, 6, 2) = '09'THEN terminal_id ELSE NULL END AS september,
          CASE WHEN substr(date, 6, 2) = '10'THEN terminal_id ELSE NULL END AS october,
          CASE WHEN substr(date, 6, 2) = '11'THEN terminal_id ELSE NULL END AS november,
          CASE WHEN substr(date, 6, 2) = '12'THEN terminal_id ELSE NULL END AS december
        FROM
          sales
        WHERE
          date BETWEEN '#{ @year }-01-01' AND '#{ @year }-12-31'
          AND sales > 0.0
      ) AS s
        INNER JOIN games AS g
          ON s.game_id = g.id
      GROUP BY game_id
      ORDER BY game_id
    EOT
    @terminals = ActiveRecord::Base.connection.execute qry
    @terminals.each do |row|
      %W{january february march april may june july august september
         october november december}.each do |m|
          row[m] = nil if row[m] == 0
      end
    end

    # terminals: total active terminals per month
    qry =<<-EOT

      --
      -- ALL GAMES: total active terminals per month
      --
      SELECT
        COUNT(DISTINCT s.january)    AS january,
        COUNT(DISTINCT s.february)   AS february,
        COUNT(DISTINCT s.march)      AS march,
        COUNT(DISTINCT s.april)      AS april,
        COUNT(DISTINCT s.may)        AS may,
        COUNT(DISTINCT s.june)       AS june,
        COUNT(DISTINCT s.july)       AS july,
        COUNT(DISTINCT s.august)     AS august,
        COUNT(DISTINCT s.september)  AS september,
        COUNT(DISTINCT s.october)    AS october,
        COUNT(DISTINCT s.november)   AS november,
        COUNT(DISTINCT s.december)   AS december
      FROM (
        SELECT
          game_id,
          CASE WHEN substr(date, 6, 2) = '01'THEN terminal_id ELSE NULL END AS january,
          CASE WHEN substr(date, 6, 2) = '02'THEN terminal_id ELSE NULL END AS february,
          CASE WHEN substr(date, 6, 2) = '03'THEN terminal_id ELSE NULL END AS march,
          CASE WHEN substr(date, 6, 2) = '04'THEN terminal_id ELSE NULL END AS april,
          CASE WHEN substr(date, 6, 2) = '05'THEN terminal_id ELSE NULL END AS may,
          CASE WHEN substr(date, 6, 2) = '06'THEN terminal_id ELSE NULL END AS june,
          CASE WHEN substr(date, 6, 2) = '07'THEN terminal_id ELSE NULL END AS july,
          CASE WHEN substr(date, 6, 2) = '08'THEN terminal_id ELSE NULL END AS august,
          CASE WHEN substr(date, 6, 2) = '09'THEN terminal_id ELSE NULL END AS september,
          CASE WHEN substr(date, 6, 2) = '10'THEN terminal_id ELSE NULL END AS october,
          CASE WHEN substr(date, 6, 2) = '11'THEN terminal_id ELSE NULL END AS november,
          CASE WHEN substr(date, 6, 2) = '12'THEN terminal_id ELSE NULL END AS december
        FROM
          sales
        WHERE
          date BETWEEN '#{ @year }-01-01' AND '#{ @year }-12-31'
          AND sales > 0.0
      ) AS s
        INNER JOIN games AS g
          ON s.game_id = g.id
    EOT
    @terminal_totals = ActiveRecord::Base.connection.execute qry
    @terminal_totals.each do |row|
      %W{january february march april may june july august september
         october november december}.each do |m|
          row[m] = nil if row[m] == 0
      end
    end

    respond_to do |fmt|
      fmt.json { 
        Rails.logger.info 'FROM JSON'
        render json: { 
          first_year:       @first_year,
          last_year:        @last_year,
          year:             @year,
          sales:            @sales,
          terminals:        @terminals,
          terminal_totals:  @terminal_totals,
        }
      }
      fmt.html 
    end

  end

  ##
  # instant games only
  def instants_annually_per_month_per_game
    @first_year = Sale.minimum(:date).year
    @last_year  = Sale.maximum(:date).year

    @year = params[:id] || @last_year

    qry =<<-EOT
      --
      -- INSTANTS: sales (money)
      --
      SELECT
        s.game_id         AS game_id,
        g.name            AS name,
        SUM(s.january)    AS january,
        SUM(s.february)   AS february,
        SUM(s.march)      AS march,
        SUM(s.april)      AS april,
        SUM(s.may)        AS may,
        SUM(s.june)       AS june,
        SUM(s.july)       AS july,
        SUM(s.august)     AS august,
        SUM(s.september)  AS september,
        SUM(s.october)    AS october,
        SUM(s.november)   AS november,
        SUM(s.december)   AS december
      FROM (
        SELECT
          game_id,
          CASE WHEN substr(date, 6, 2) = '01'THEN sales ELSE NULL END AS january,
          CASE WHEN substr(date, 6, 2) = '02'THEN sales ELSE NULL END AS february,
          CASE WHEN substr(date, 6, 2) = '03'THEN sales ELSE NULL END AS march,
          CASE WHEN substr(date, 6, 2) = '04'THEN sales ELSE NULL END AS april,
          CASE WHEN substr(date, 6, 2) = '05'THEN sales ELSE NULL END AS may,
          CASE WHEN substr(date, 6, 2) = '06'THEN sales ELSE NULL END AS june,
          CASE WHEN substr(date, 6, 2) = '07'THEN sales ELSE NULL END AS july,
          CASE WHEN substr(date, 6, 2) = '08'THEN sales ELSE NULL END AS august,
          CASE WHEN substr(date, 6, 2) = '09'THEN sales ELSE NULL END AS september,
          CASE WHEN substr(date, 6, 2) = '10'THEN sales ELSE NULL END AS october,
          CASE WHEN substr(date, 6, 2) = '11'THEN sales ELSE NULL END AS november,
          CASE WHEN substr(date, 6, 2) = '12'THEN sales ELSE NULL END AS december
        FROM
          sales
        WHERE
          date BETWEEN '#{ @year }-01-01' AND '#{ @year }-12-31'
          AND sales > 0.0
      ) AS s
        INNER JOIN games AS g
          ON s.game_id = g.id
      WHERE
          g.type = 'INSTANT'
      GROUP BY game_id
      ORDER BY game_id
    EOT
    @sales = ActiveRecord::Base.connection.execute qry

    # tickets
    qry =<<-EOT

      --
      -- INSTANTS: tickets
      --
      SELECT
        s.game_id         AS game_id,
        g.name            AS name,
        SUM(s.january)/g.price    AS january,
        SUM(s.february)/g.price   AS february,
        SUM(s.march)/g.price      AS march,
        SUM(s.april)/g.price      AS april,
        SUM(s.may)/g.price        AS may,
        SUM(s.june)/g.price       AS june,
        SUM(s.july)/g.price       AS july,
        SUM(s.august)/g.price     AS august,
        SUM(s.september)/g.price  AS september,
        SUM(s.october)/g.price    AS october,
        SUM(s.november)/g.price   AS november,
        SUM(s.december)/g.price   AS december
      FROM (
        SELECT
          game_id,
          CASE WHEN substr(date, 6, 2) = '01'THEN sales ELSE NULL END AS january,
          CASE WHEN substr(date, 6, 2) = '02'THEN sales ELSE NULL END AS february,
          CASE WHEN substr(date, 6, 2) = '03'THEN sales ELSE NULL END AS march,
          CASE WHEN substr(date, 6, 2) = '04'THEN sales ELSE NULL END AS april,
          CASE WHEN substr(date, 6, 2) = '05'THEN sales ELSE NULL END AS may,
          CASE WHEN substr(date, 6, 2) = '06'THEN sales ELSE NULL END AS june,
          CASE WHEN substr(date, 6, 2) = '07'THEN sales ELSE NULL END AS july,
          CASE WHEN substr(date, 6, 2) = '08'THEN sales ELSE NULL END AS august,
          CASE WHEN substr(date, 6, 2) = '09'THEN sales ELSE NULL END AS september,
          CASE WHEN substr(date, 6, 2) = '10'THEN sales ELSE NULL END AS october,
          CASE WHEN substr(date, 6, 2) = '11'THEN sales ELSE NULL END AS november,
          CASE WHEN substr(date, 6, 2) = '12'THEN sales ELSE NULL END AS december
        FROM
          sales
        WHERE
          date BETWEEN '#{ @year }-01-01' AND '#{ @year }-12-31'
          AND sales > 0.0
      ) AS s
        INNER JOIN games AS g
          ON s.game_id = g.id
      WHERE
          g.type = 'INSTANT'
      GROUP BY game_id
      ORDER BY game_id
    EOT
    @tickets = ActiveRecord::Base.connection.execute qry

    # terminals
    qry =<<-EOT

      --
      -- INSTANTS: active terminals per game
      --
      SELECT
        s.game_id         AS game_id,
        g.name            AS name,
        COUNT(DISTINCT s.january)    AS january,
        COUNT(DISTINCT s.february)   AS february,
        COUNT(DISTINCT s.march)      AS march,
        COUNT(DISTINCT s.april)      AS april,
        COUNT(DISTINCT s.may)        AS may,
        COUNT(DISTINCT s.june)       AS june,
        COUNT(DISTINCT s.july)       AS july,
        COUNT(DISTINCT s.august)     AS august,
        COUNT(DISTINCT s.september)  AS september,
        COUNT(DISTINCT s.october)    AS october,
        COUNT(DISTINCT s.november)   AS november,
        COUNT(DISTINCT s.december)   AS december
      FROM (
        SELECT
          game_id,
          CASE WHEN substr(date, 6, 2) = '01'THEN terminal_id ELSE NULL END AS january,
          CASE WHEN substr(date, 6, 2) = '02'THEN terminal_id ELSE NULL END AS february,
          CASE WHEN substr(date, 6, 2) = '03'THEN terminal_id ELSE NULL END AS march,
          CASE WHEN substr(date, 6, 2) = '04'THEN terminal_id ELSE NULL END AS april,
          CASE WHEN substr(date, 6, 2) = '05'THEN terminal_id ELSE NULL END AS may,
          CASE WHEN substr(date, 6, 2) = '06'THEN terminal_id ELSE NULL END AS june,
          CASE WHEN substr(date, 6, 2) = '07'THEN terminal_id ELSE NULL END AS july,
          CASE WHEN substr(date, 6, 2) = '08'THEN terminal_id ELSE NULL END AS august,
          CASE WHEN substr(date, 6, 2) = '09'THEN terminal_id ELSE NULL END AS september,
          CASE WHEN substr(date, 6, 2) = '10'THEN terminal_id ELSE NULL END AS october,
          CASE WHEN substr(date, 6, 2) = '11'THEN terminal_id ELSE NULL END AS november,
          CASE WHEN substr(date, 6, 2) = '12'THEN terminal_id ELSE NULL END AS december
        FROM
          sales
        WHERE
          date BETWEEN '#{ @year }-01-01' AND '#{ @year }-12-31'
          AND sales > 0.0
      ) AS s
        INNER JOIN games AS g
          ON s.game_id = g.id
      WHERE
          g.type = 'INSTANT'
      GROUP BY game_id
      ORDER BY game_id
    EOT
    @terminals = ActiveRecord::Base.connection.execute qry
    @terminals.each do |row|
      %W{january february march april may june july august september
         october november december}.each do |m|
          row[m] = nil if row[m] == 0
      end
    end

    # terminals: total active terminals per month
    qry =<<-EOT

      --
      -- INSTANTS: total active terminals per month
      --
      SELECT
        COUNT(DISTINCT s.january)    AS january,
        COUNT(DISTINCT s.february)   AS february,
        COUNT(DISTINCT s.march)      AS march,
        COUNT(DISTINCT s.april)      AS april,
        COUNT(DISTINCT s.may)        AS may,
        COUNT(DISTINCT s.june)       AS june,
        COUNT(DISTINCT s.july)       AS july,
        COUNT(DISTINCT s.august)     AS august,
        COUNT(DISTINCT s.september)  AS september,
        COUNT(DISTINCT s.october)    AS october,
        COUNT(DISTINCT s.november)   AS november,
        COUNT(DISTINCT s.december)   AS december
      FROM (
        SELECT
          game_id,
          CASE WHEN substr(date, 6, 2) = '01'THEN terminal_id ELSE NULL END AS january,
          CASE WHEN substr(date, 6, 2) = '02'THEN terminal_id ELSE NULL END AS february,
          CASE WHEN substr(date, 6, 2) = '03'THEN terminal_id ELSE NULL END AS march,
          CASE WHEN substr(date, 6, 2) = '04'THEN terminal_id ELSE NULL END AS april,
          CASE WHEN substr(date, 6, 2) = '05'THEN terminal_id ELSE NULL END AS may,
          CASE WHEN substr(date, 6, 2) = '06'THEN terminal_id ELSE NULL END AS june,
          CASE WHEN substr(date, 6, 2) = '07'THEN terminal_id ELSE NULL END AS july,
          CASE WHEN substr(date, 6, 2) = '08'THEN terminal_id ELSE NULL END AS august,
          CASE WHEN substr(date, 6, 2) = '09'THEN terminal_id ELSE NULL END AS september,
          CASE WHEN substr(date, 6, 2) = '10'THEN terminal_id ELSE NULL END AS october,
          CASE WHEN substr(date, 6, 2) = '11'THEN terminal_id ELSE NULL END AS november,
          CASE WHEN substr(date, 6, 2) = '12'THEN terminal_id ELSE NULL END AS december
        FROM
          sales
        WHERE
          date BETWEEN '#{ @year }-01-01' AND '#{ @year }-12-31'
          AND sales > 0.0
      ) AS s
        INNER JOIN games AS g
          ON s.game_id = g.id
      WHERE
          g.type = 'INSTANT'
    EOT
    @terminal_totals = ActiveRecord::Base.connection.execute qry
    @terminal_totals.each do |row|
      %W{january february march april may june july august september
         october november december}.each do |m|
          row[m] = nil if row[m] == 0
      end
    end
    respond_to do |fmt|
      fmt.json { 
        Rails.logger.info 'FROM JSON'
        render json: { 
          first_year:       @first_year,
          last_year:        @last_year,
          year:             @year,
          sales:            @sales,
          tickets:          @tickets,
          terminals:        @terminals,
          terminal_totals:  @terminal_totals,
        }
      }
      fmt.html 
    end
  end

  ##
  # instant general info
  def instants_general
    qry =<<-EOT

      --
      -- INSTANTS: GENERAL INFO
      --
      SELECT
        g.id                  AS game_id,
        g.name                AS name,
        g.price               AS price,
        c.categories          AS categories,
        c.winning             AS winning,
        c.winning_amount      AS winnings_fund,
        g.volume              AS volume,
        SUM(s.sales)/g.price  AS sold,
        MIN(s.date)           AS started_on,
        MAX(s.date)           AS last_sales_on
      FROM
        sales AS s
        INNER JOIN games AS g
          ON s.game_id = g.id
        INNER JOIN (
          SELECT 
            game_id, 
            COUNT(*)    AS categories,
            SUM(count)  AS winning,
            SUM(amount*count) AS winning_amount
          FROM categories
          GROUP BY game_id
        ) AS c
          ON s.game_id = c.game_id
      WHERE
        g.type = 'INSTANT'
      GROUP BY g.id
    EOT
    @general_info = ActiveRecord::Base.connection.execute qry
    @last_sales_on = Sale.maximum(:date)
    respond_to do |fmt|
      fmt.json { render json: @general_info }
      fmt.html 
    end
  end
  
  def sales_per_city
    unless params[:from] and  params[:to]
      @to   = Sale.maximum(:date)
      @from = @to - 29
    else
      @from = Date.parse params[:from]
      @to   = Date.parse params[:to]
    end

    term_sales = Sale.
          select('s.terminal_id AS terminal_id, t.name AS name,' +
                 ' t.city AS city, SUM(s.sales) AS sales').
          joins('AS s INNER JOIN terminals AS t ON s.terminal_id = t.id').
          where('s.date' => @from .. @to).
          where('s.sales > 0.0').
          group('s.terminal_id')

    qry =<<-EOT
      SELECT
        ts.city                         AS city,
        SUM(ts.sales)                   AS city_sales,
        COUNT(DISTINCT ts.terminal_id)  AS term_count,
        MIN(ts.sales)                   AS min_term_sales,
        AVG(ts.sales)                   AS avg_term_sales,
        MAX(ts.sales)                   AS max_term_sales

      FROM (
        SELECT
          s.terminal_id   AS terminal_id,
          t.city          AS city,
          SUM(s.sales)    AS sales

        FROM
          sales AS s 
          INNER JOIN terminals AS t
            ON s.terminal_id = t.id

        WHERE
          s.date BETWEEN '#{ @from.strftime YMD }' AND '#{ @to.strftime YMD }'
          AND s.sales > 0

        GROUP BY s.terminal_id

      ) AS ts
      GROUP BY ts.city
      ORDER BY term_count DESC
    EOT

    city_sales = ActiveRecord::Base.connection.execute qry
    ts_arr = term_sales.to_a
    cs_arr = city_sales.to_a

    cs_arr.each do |r|
      t = ts_arr.select {|ts| ts['city'] == r['city'] and ts['sales'] >= r['max_term_sales']}[0]
      r.merge!({
        'terminal_id'   => t['terminal_id'],
        'terminal_name' => t['name'],
      })
    end
    @total_sales  = cs_arr.inject(0) {|s, x| s + x['city_sales']}
    @city_sales   = cs_arr

    respond_to do |fmt|
      fmt.json { 
        Rails.logger.info 'FROM JSON: Sales per city'
        render json: { 
          from:         @from,
          to:           @to,
          total_sales:  @total_sales,
          city_sales:   @city_sales,
        }
      }

      fmt.html 
    end
  end

private
  def month_diff(d1, d2)
    d1 = Date.parse d1 unless d1.instance_of? Date
    d2 = Date.parse d2 unless d2.instance_of? Date
    d1, d2 = [d2, d1] if d1 > d2
      
    d2.year*12 + d2.month - d1.year*12 - d1.month
    # jan 2017 - nov 2016: 12 + 1 - 11 => 2
  end
end
