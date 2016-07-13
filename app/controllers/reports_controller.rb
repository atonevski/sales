class ReportsController < ApplicationController

  skip_after_action :verify_authorized, :verify_policy_scoped

  def annually_per_month_per_game
    @first_year = Sale.minimum(:date).year
    @last_year  = Sale.maximum(:date).year

    @year = params[:id] || @last_year

    qry =<<-EOT
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
    respond_to do |fmt|
      fmt.json { 
        Rails.logger.info 'FROM JSON'
        render json: @sales 
      }
      fmt.html 
    end

  end
end
