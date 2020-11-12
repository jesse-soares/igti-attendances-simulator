-- REPORT: attendances lost reasons

-- granularity: brands
SELECT
  lr.code, lr.description,
  b.id AS brand_id,
  b.name AS brand_name,
  COUNT(a.*) AS attendances_count
FROM attendances a,
     sellers s,
     stores st,
     brands b,
     lost_reasons lr
WHERE a.seller_id = s.id
  AND s.store_id = st.id
  AND st.brand_id = b.id
  AND a.lost_reason_code = lr.code
  AND b.id IN (1)
--  AND date_trunc('day', a.start_at) BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY
  lr.code, lr.description,
  b.id, b.name;

-- mongodb
db.mongo_lost_reasons.aggregate([
  {
    $match: {
      brand_id: 1
    }
  },
  {
    $group: {
      _id: { code: "$lost_reason_code", description: "$lost_reason_description" },
      total: { $sum: "$attendances_count" }
    }
  }
])

-- granularity: stores
SELECT
  lr.code, lr.description,
  st.id AS store_id,
  st.name AS store_name,
  b.id AS brand_id,
  b.name AS brand_name,
  COUNT(a.*) AS attendances_count
FROM attendances a,
     sellers s,
     stores st,
     brands b,
     lost_reasons lr
WHERE a.seller_id = s.id
  AND s.store_id = st.id
  AND st.brand_id = b.id
  AND a.lost_reason_code = lr.code
  AND b.id IN (1)
--  AND date_trunc('day', a.start_at) BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY
  lr.code, lr.description,
  st.id, st.name,
  b.id, b.name;

-- granularity: sellers
SELECT
  lr.code, lr.description,
  s.id AS seller_id,
  s."name" AS seller_name,
  st.id AS store_id,
  st.name AS store_name,
  b.id AS brand_id,
  b.name AS brand_name,
  COUNT(a.*) AS attendances_count
FROM attendances a,
     sellers s,
     stores st,
     brands b,
     lost_reasons lr
WHERE a.seller_id = s.id
  AND s.store_id = st.id
  AND st.brand_id = b.id
  AND a.lost_reason_code = lr.code
  AND b.id IN (1)
--  AND date_trunc('day', a.start_at) BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY
  lr.code, lr.description,
  s.id, s.name,
  st.id, st.name,
  b.id, b.name;
