CREATE TEMP TABLE temp_ndvi AS
SELECT f.field_id,
 	   ndd.ndvi,
 	   f.crop_id,
 	   f.country_id,
 	   f.api_user_id,
 	   ndd.date,
 	   ndd.ndvi_date_difference,
 	   f.planting_type_id
   FROM field f
		INNER JOIN (
			SELECT 
			    nhn.field_id AS ndvi_field_id,
			    nhn.ndvi AS ndvi,
			    f2.api_user_id AS api_user_id,
			    f2.crop_id AS crop_id,
				nhn.date,
				(CURRENT_DATE - f2.planting_date) + 1  AS ndvi_date_difference
			FROM (
				SELECT 
			        field_id,
			        ndvi,
			        "date"
			    FROM ndvi_history
			    where "date" = current_date 
			) AS nhn
			INNER JOIN field f2 ON nhn.field_id = f2.field_id
			WHERE 
			    f2.api_user_id = 'api_key'
			    AND f2.planting_date IS NOT NULL
			GROUP BY 
			    nhn.field_id,
			    nhn.ndvi,
			    nhn."date",
			    f2.api_user_id,
			    f2.crop_id,
			    f2.planting_date
			HAVING 
			    (f2.crop_id = 105 AND CURRENT_DATE - f2.planting_date + 1 < 156)
			    OR (f2.crop_id = 108 AND CURRENT_DATE - f2.planting_date + 1 < 131)
		) AS ndd ON f.field_id = ndd.ndvi_field_id


SELECT 
    upg_f.field_id, 
    upg_f.crop_id,
    fpb.doy, 
    fpb.b1s, 
    upg_f.ndvi, 
    upg_f.date    
FROM temp_ndvi_new2 AS upg_f
INNER JOIN crop c ON upg_f.crop_id = c.id
INNER JOIN field_performance_bands_by_user fpb ON upg_f.country_id = fpb.country_id
    AND upg_f.crop_id = fpb.crop_id
    AND fpb.planting_type_id = upg_f.planting_type_id
    AND c.have_bands
    AND fpb.doy = upg_f.ndvi_date_difference
    AND upg_f.api_user_id = fpb.api_user_id 
WHERE upg_f.ndvi < fpb.b1s  
AND fpb.txt_field_yield = 'Good'