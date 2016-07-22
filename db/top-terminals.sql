SELECT
  s.terminal_id                 AS terminal_id,
  t.city                        AS city,
  SUM(s.sales)                  AS sales

FROM
  sales AS s
  INNER JOIN terminals AS t
    ON t.id = s.terminal_id
WHERE
  s.date BETWEEN '2016-07-20' AND '2016-06-21'
GROUP BY s.terminal_id


# last 30 days
to = Sale.maximum(:date)
from = to - 29 

term_sales = Sale.
      select('s.terminal_id AS terminal_id, t.name AS name, t.city AS city, SUM(s.sales) AS sales').
      joins('AS s INNER JOIN terminals AS t ON s.terminal_id = t.id').
      where('s.date' => from .. to).
      where('s.sales > 0.0').
      group('s.terminal_id')

ymd = '%Y-%m-%d'

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
      s.date BETWEEN '#{ from.strftime ymd }' AND '#{ to.strftime ymd }'
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
  t = ts_arr.select {|ts| ts['sales'] >= r['max_term_sales']}[0]
  r.merge! {
    'terminal_id'   => t['terminal_id'],
    'terminal_name' => t['name'],
  }
end
