WITH q_transaction_v01 AS (SELECT
        *
      FROM
        `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_transaction`
      )
SELECT
	q_view_v01.context_id  AS q_view_v01_context_id,
	q_view_v01.context_viewNumber  AS q_view_v01_context_view_number,
	q_view_v01.context_sessionNumber  AS q_view_v01_context_session_number,
	FORMAT_TIMESTAMP('%F %T', q_view_v01.property_event_ts ) AS q_view_v01_time_data_points_time,
	q_view_v01.meta_url  AS q_view_v01_meta_url,
	q_view_v01.page_subtype  AS q_view_v01_page_subtype,
	COUNT(DISTINCT q_transaction_v01.transaction_id)  AS q_transaction_v01_transactions,
	COALESCE(ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE(q_transaction_v01.basket_total_baseValue ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6), 0) AS q_transaction_v01_sum_of_transaction_total
FROM `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_view`  AS q_view_v01
LEFT JOIN q_transaction_v01 ON q_view_v01.view_id  = q_transaction_v01.view_id

WHERE ((UPPER(q_view_v01.context_id ) = UPPER('2gavh8ihjvd-0keypz4to-4grxakw'))) AND ((((q_view_v01.property_event_ts ) >= ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -6 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -6 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS DATE), INTERVAL 7 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -6 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP)) AS STRING))))))))
GROUP BY 1,2,3,4,5,6
ORDER BY 2
