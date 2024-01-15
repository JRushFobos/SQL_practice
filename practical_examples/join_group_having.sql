--1st---------------------------------------
SELECT f.field_id,
       MAX(nh.ndvi)     as last_ndvi,
       MAX(nh.raw_ndvi) as last_raw_ndvi,
       MAX(nh."date")   as last_date_ndvi
FROM  (SELECT * from field f
       inner join (
       SELECT nh.field_id as ndvi_field_id,
              MAX(nh."date") - f2.planting_date + 1 AS ndvi_date_difference
              FROM ndvi_history nh
              INNER JOIN field f2  ON nh.field_id = f2.field_id
              GROUP BY f2.planting_date, nh.field_id) ndd ON f.field_id = ndd.ndvi_field_id
    ) f
INNER JOIN ndvi_history nh ON f.field_id = nh.field_id
INNER JOIN crop c ON f.crop_id = id
INNER JOIN field_performance_bands fpb ON f.country_id = fpb.country_id
    AND f.crop_id = fpb.crop_id
    AND fpb.planting_type_id = f.planting_type_id
    AND c.have_bands
    AND fpb.dos = f.ndvi_date_difference
WHERE f.api_user_id = 'apikey'
  AND f.crop_id IS NOT NULL
  and f.planting_date is not null
group by f.field_id, fpb.b2s
having MAX(nh.ndvi) < fpb.b2s;

--update #1---------------------------------------------
SELECT f.field_id,
       MAX(nh."date")   as last_date_ndvi
FROM  (SELECT * from field f
       inner join (
			       SELECT nh.field_id as ndvi_field_id,
			              MAX(nh."date") - f2.planting_date + 1 AS ndvi_date_difference
						  FROM ndvi_history nh
						  INNER JOIN field f2  ON nh.field_id = f2.field_id
						  where f2.api_user_id = 'apikey'
						      AND f2.crop_id IS NOT NULL
						      AND f2.planting_date is not null
						  GROUP BY f2.planting_date, nh.field_id) ndd
		ON f.field_id = ndd.ndvi_field_id
    ) f
INNER JOIN ndvi_history nh ON f.field_id = nh.field_id
INNER JOIN crop c ON f.crop_id = id
INNER JOIN field_performance_bands fpb ON f.country_id = fpb.country_id
    AND f.crop_id = fpb.crop_id
    AND fpb.planting_type_id = f.planting_type_id
    AND c.have_bands
    AND fpb.dos = f.ndvi_date_difference
group by f.field_id, fpb.b2s, nh.ndvi
having nh.ndvi < fpb.b2s

--update #2---------------------------------------------
SELECT f.field_id, f.crop_id, fpb.dos, fpb.b1s, f.ndvi, f.ndvi_date
FROM  (SELECT *, ndd.ndvi_field_id
	   FROM field f
			INNER JOIN (
				SELECT
				    nhn.field_id AS ndvi_field_id,
				    nhn.ndvi AS ndvi,
				    CASE
				    	WHEN nhn."date" > CURRENT_DATE THEN CURRENT_DATE
					    ELSE nhn."date"
			        END AS ndvi_date,
				    MAX(nhn."date") - f2.planting_date + 1 AS ndvi_date_difference
				FROM (
				    SELECT
				        field_id,
				        ndvi,
				        "date",
				        ROW_NUMBER() OVER (PARTITION BY field_id ORDER BY "date" DESC) AS rn
				    FROM ndvi_history
				) AS nhn
				INNER JOIN field f2 ON nhn.field_id = f2.field_id
				WHERE f2.api_user_id = 'apikey'
				      AND f2.crop_id IS NOT NULL
				      AND f2.planting_date IS NOT NULL
				      AND rn = 1
				GROUP BY nhn.field_id, nhn.ndvi, nhn."date", f2.planting_date
			) AS ndd ON f.field_id = ndd.ndvi_field_id
      ) f
INNER JOIN crop c ON f.crop_id = c.id
INNER JOIN field_performance_bands_by_user fpb ON f.country_id = fpb.country_id
    AND f.crop_id = fpb.crop_id
    AND fpb.planting_type_id = f.planting_type_id
    AND c.have_bands
    AND fpb.dos = f.ndvi_date_difference
    and f.api_user_id = fpb.api_user_id
Where f.ndvi < fpb.b1s  and fpb.txt_field_yield = 'Good'

--step1-------------------------------------
SELECT nh.field_id as ndvi_field_id,
       MAX(nh."date") - f2.planting_date + 1 AS ndvi_date_difference
FROM ndvi_history nh
INNER JOIN field f2  ON nh.field_id = f2.field_id
where f2.api_user_id = 'apikey'
      AND f2.crop_id IS NOT NULL
      AND f2.planting_date is not null
GROUP BY f2.planting_date, nh.field_id


--update step1------------------------------------
SELECT
    nhn.field_id AS ndvi_field_id,
    nhn.ndvi AS ndvi,
    f2.api_user_id AS api_user_id,
    f2.crop_id AS crop_id,
    rn,
    CASE
        WHEN nhn."date" > CURRENT_DATE THEN CURRENT_DATE
        ELSE nhn."date"
    END AS ndvi_date,
    nhn."date" - f2.planting_date + 1 AS ndvi_date_difference
FROM (
    SELECT
        field_id,
        ndvi,
        "date",
        ROW_NUMBER() OVER (PARTITION BY field_id ORDER BY "date" DESC) AS rn
    FROM ndvi_history
) AS nhn
INNER JOIN field f2 ON nhn.field_id = f2.field_id
WHERE
    f2.api_user_id = 'apikey'
    AND f2.crop_id IS NOT NULL
    AND (f2.crop_id = 105 OR f2.crop_id = 108)
    AND f2.planting_date IS NOT NULL
GROUP BY
    nhn.field_id,
    nhn.ndvi,
    nhn."date",
    f2.api_user_id,
    f2.crop_id,
    rn,
    f2.planting_date
HAVING
    rn = 1;

--step2------------------------------------
SELECT *, ndd.ndvi_field_id
FROM field f
INNER JOIN (
    SELECT nh.field_id AS ndvi_field_id,
           MAX(nh."date") - f2.planting_date + 1 AS ndvi_date_difference
    FROM ndvi_history nh
    INNER JOIN field f2 ON nh.field_id = f2.field_id
    WHERE f2.api_user_id = 'apikey'
        AND f2.crop_id IS NOT NULL
        AND f2.planting_date IS NOT NULL
    GROUP BY f2.planting_date, nh.field_id
) AS ndd ON f.field_id = ndd.ndvi_field_id;

--update step2------------------------------------

SELECT *, ndd.ndvi_field_idfieldId
FROM field f
INNER JOIN (
	SELECT
	    nhn.field_id AS ndvi_field_id,
	    nhn.ndvi AS ndvi,
	    CASE
	    	WHEN nhn."date" > CURRENT_DATE THEN CURRENT_DATE
		    ELSE nhn."date"
        END AS ndvi_date,
	    MAX(nhn."date") - f2.planting_date + 1 AS ndvi_date_difference
	FROM (
	    SELECT
	        field_id,
	        ndvi,
	        "date",
	        ROW_NUMBER() OVER (PARTITION BY field_id ORDER BY "date" DESC) AS rn
	    FROM ndvi_history
	) AS nhn
	INNER JOIN field f2 ON nhn.field_id = f2.field_id
	WHERE f2.api_user_id = 'apikey'
	      AND f2.crop_id IS NOT NULL
	      AND f2.planting_date IS NOT NULL
	      AND rn = 1
	GROUP BY nhn.field_id, nhn.ndvi, nhn."date", f2.planting_date
) AS ndd ON f.field_id = ndd.ndvi_field_id

--2nd---------------------------------------
SELECT distinct (f.field_id),
       fpb.dos,
	   nh.ndvi,
       nh.raw_ndvi,
       MAX(nh."date") as last_date_ndvi
FROM field f
INNER JOIN (
    SELECT nh.field_id, MAX(nh."date") - f2.planting_date + 1 AS ndvi_date_difference
    FROM ndvi_history nh
    INNER JOIN field f2 ON nh.field_id = f2.field_id
    WHERE f2.field_id = nh.field_id
    GROUP BY f2.planting_date, nh.field_id
) mdd ON f.field_id = mdd.field_id
INNER JOIN ndvi_history nh ON f.field_id = nh.field_id
INNER JOIN crop c ON f.crop_id = c.id
INNER JOIN field_performance_bands fpb ON f.country_id = fpb.country_id
    AND f.crop_id = fpb.crop_id
    AND fpb.planting_type_id = f.planting_type_id
    AND c.have_bands
    AND fpb.dos = mdd.ndvi_date_difference
WHERE f.api_user_id = 'apikey'
    AND f.crop_id IS NOT NULL
    AND f.planting_date IS NOT NULL
GROUP BY f.field_id, fpb.b2s, nh.ndvi, nh.raw_ndvi, fpb.dos
HAVING MAX(nh.ndvi) < fpb.b2s;
