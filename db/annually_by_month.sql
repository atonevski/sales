--
-- sales 
--
SELECT
  s.game_id,
  g.name,
  SUM(s.january),
  SUM(s.february),
  SUM(s.march),
  SUM(s.april),
  SUM(s.may),
  SUM(s.june),
  SUM(s.july),
  SUM(s.august),
  SUM(s.september),
  SUM(s.october),
  SUM(s.november),
  SUM(s.december)
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
    --- substr(date, 1, 4) = '2011'
    date BETWEEN '2011-01-01' AND '2011-12-31'
    AND sales > 0.0
) AS s
  INNER JOIN games AS g
    ON s.game_id = g.id
GROUP BY game_id
ORDER BY game_id

--
-- Active terminals by game
--
SELECT
  s.game_id,
  g.name,
  COUNT(DISTINCT s.january),
  COUNT(DISTINCT s.february),
  COUNT(DISTINCT s.march),
  COUNT(DISTINCT s.april),
  COUNT(DISTINCT s.may),
  COUNT(DISTINCT s.june),
  COUNT(DISTINCT s.july),
  COUNT(DISTINCT s.august),
  COUNT(DISTINCT s.september),
  COUNT(DISTINCT s.october),
  COUNT(DISTINCT s.november),
  COUNT(DISTINCT s.december)
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
    --- substr(date, 1, 4) = '2011'
    date BETWEEN '2015-01-01' AND '2015-12-31'
) AS s
  INNER JOIN games AS g
    ON s.game_id = g.id
GROUP BY game_id
ORDER BY game_id


--
-- INSTANTS ONLY (MONEY)
--
SELECT
  s.game_id,
  g.name,
  SUM(s.january),
  SUM(s.february),
  SUM(s.march),
  SUM(s.april),
  SUM(s.may),
  SUM(s.june),
  SUM(s.july),
  SUM(s.august),
  SUM(s.september),
  SUM(s.october),
  SUM(s.november),
  SUM(s.december)
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
    --- substr(date, 1, 4) = '2011'
    date BETWEEN '2011-01-01' AND '2011-12-31'
    AND sales > 0
) AS s
  INNER JOIN games AS g
    ON s.game_id = g.id
WHERE
    g.type = 'INSTANT'

GROUP BY game_id
ORDER BY game_id


--
-- INSTANTS ONLY (TICKETS)
--
SELECT
  s.game_id,
  g.name,
  SUM(s.january)/g.price,
  SUM(s.february)/g.price,
  SUM(s.march)/g.price,
  SUM(s.april)/g.price,
  SUM(s.may)/g.price,
  SUM(s.june)/g.price,
  SUM(s.july)/g.price,
  SUM(s.august)/g.price,
  SUM(s.september)/g.price,
  SUM(s.october)/g.price,
  SUM(s.november)/g.price,
  SUM(s.december)/g.price
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
    --- substr(date, 1, 4) = '2011'
    date BETWEEN '2015-01-01' AND '2015-12-31'
    AND sales > 0
) AS s
  INNER JOIN games AS g
    ON s.game_id = g.id
WHERE
    g.type = 'INSTANT'

GROUP BY game_id
ORDER BY game_id
