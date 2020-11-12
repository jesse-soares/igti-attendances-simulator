-- TAXA DE CONVERSAO [TODO]
SELECT
  s.id AS seller_id,
  s."name" AS seller_name,
  st.id AS store_id,
  st.name AS store_name,
  b.id AS brand_id,
  b.name AS brand_name,
  a.attendance_type_code,
  COUNT(a.*) AS attendances_count
FROM attendances a,
     sellers s,
     stores st,
     brands b
WHERE a.seller_id = s.id
  AND s.store_id = st.id
  AND st.brand_id = b.id
  AND s.id = 1
  AND date_trunc('day', a.start_at) BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY
  a.attendance_type_code,
  s.id, s.name,
  st.id, st.name,
  b.id, b.name;
