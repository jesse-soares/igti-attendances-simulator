-- REPORT: attendances average time

-- granularity: brands
SELECT
  b.id AS brand_id,
  b.name AS brand_name,
  AVG(a.end_at - a.start_at)
FROM attendances a,
     sellers s,
     stores st,
     brands b
WHERE a.seller_id = s.id
  AND s.store_id = st.id
  AND st.brand_id = b.id
  AND b.id IN (1, 5, 10)
  --  AND date_trunc('day', a.start_at) BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY
  b.id, b.name;

-- granularity: stores
SELECT
  st.id AS store_id,
  st.name AS store_name,
  b.id AS brand_id,
  b.name AS brand_name,
  AVG(a.end_at - a.start_at)
FROM attendances a,
     sellers s,
     stores st,
     brands b
WHERE a.seller_id = s.id
  AND s.store_id = st.id
  AND st.brand_id = b.id
  AND b.id IN (1, 5, 10)
--  AND date_trunc('day', a.start_at) BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY
  st.id, st.name,
  b.id, b.name;

-- granularity: sellers
SELECT
  s.id AS seller_id,
  s."name" AS seller_name,
  st.id AS store_id,
  st.name AS store_name,
  b.id AS brand_id,
  b.name AS brand_name,
  AVG(a.end_at - a.start_at)
FROM attendances a,
     sellers s,
     stores st,
     brands b
WHERE a.seller_id = s.id
  AND s.store_id = st.id
  AND st.brand_id = b.id
  AND b.id IN (1, 5, 10)
--  AND date_trunc('day', a.start_at) BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY
  s.id, s.name,
  st.id, st.name,
  b.id, b.name;
