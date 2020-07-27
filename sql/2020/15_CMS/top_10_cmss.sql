#standardSQL
  # Top 10 CMSs, compared to 2019
-- #standardSQL
--   # Top 10 CMSs, compared to 2019
-- SELECT
--   *
-- FROM (
--   SELECT
--     _TABLE_SUFFIX AS client2020,
--     app AS cms2020,
--     COUNT(0) AS freq2020,
--     total AS total2020,
--     ROUND(COUNT(0) * 100 / total, 2) AS pct2020
--   FROM
--     `httparchive.technologies.2020_07_01_*`
--   JOIN (
--     SELECT
--       _TABLE_SUFFIX,
--       COUNT(0) AS total
--     FROM
--       `httparchive.summary_pages.2020_07_01_*`
--     GROUP BY
--       _TABLE_SUFFIX)
--   USING
--     (_TABLE_SUFFIX)
--   WHERE
--     category = 'CMS'
--   GROUP BY
--     client2020,
--     total2020,
--     cms2020) AS a
-- JOIN (
--   SELECT
--     _TABLE_SUFFIX AS client2019,
--     app AS cms2019,
--     COUNT(0) AS freq2019,
--     total AS total2019,
--     ROUND(COUNT(0) * 100 / total, 2) AS pct2019
--   FROM
--     `httparchive.technologies.2019_07_01_*`
--   JOIN (
--     SELECT
--       _TABLE_SUFFIX,
--       COUNT(0) AS total
--     FROM
--       `httparchive.summary_pages.2019_07_01_*`
--     GROUP BY
--       _TABLE_SUFFIX)
--   USING
--     (_TABLE_SUFFIX)
--   WHERE
--     category = 'CMS'
--   GROUP BY
--     client2019,
--     total2019,
--     cms2019) AS b
-- ON
--   a.cms2020 = b.cms2019 AND a.client2020 = b.client2019
--   ORDER BY freq2020 DESC
SELECT
  _TABLE_SUFFIX AS client,
  2020 AS year,
  app AS cms,
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM
  `httparchive.technologies.2020_07_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_07_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (_TABLE_SUFFIX)
WHERE
  category = 'CMS'
GROUP BY
  client,
  total,
  cms
UNION ALL
SELECT
  _TABLE_SUFFIX AS client,
  2019 AS year,
  app AS cms,
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM
  `httparchive.technologies.2019_07_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2019_07_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (_TABLE_SUFFIX)
WHERE
  category = 'CMS'
GROUP BY
  client,
  total,
  cms
ORDER BY
  year DESC,
  freq DESC