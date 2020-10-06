WITH q_transaction_v01 AS (SELECT
        *
      FROM
        `qubit-client-CLIENTPROJECTNUM.PROJECTNAME__v2.livetap_transaction`
      WHERE
        ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
      )
SELECT
	CAST(q_view_v01.property_event_ts  AS DATE) AS date,
	COUNT(DISTINCT q_transaction_v01.transaction_id)  AS transactions,
	COALESCE(ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE(q_transaction_v01.basket_total_baseValue ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6), 0) AS sum_of_transaction_total
FROM `qubit-client-CLIENTPROJECTNUM.PROJECTNAME__v2.livetap_view`  AS q_view_v01
LEFT JOIN q_transaction_v01 ON q_view_v01.view_id  = q_transaction_v01.view_id

WHERE
	(((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
GROUP BY 1
ORDER BY 1 DESC
