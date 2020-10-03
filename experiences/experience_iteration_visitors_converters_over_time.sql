WITH q_transaction_v01 AS (SELECT
        *
      FROM
        `qubit-client-CLIENTPROJECTNUM.CLIENTNAME____v2.livetap_transaction`
      WHERE
        ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
      )
  ,  q_experience_v01 AS (SELECT
      qp_bi_view_name,
      ts,
      property_event_ts,
      view_id,
      meta_recordDate,
      meta_trackingId,
      context_id,
      context_viewNumber,
      context_sessionNumber,
      context_conversionNumber,
      meta_ts,
      meta_serverTs,
      experience.experienceId AS experienceId,
      experience.experienceName AS experienceName,
      experience.variationMasterId AS variationMasterId,
      experience.variationName AS variationName,
      experience.iterationName AS iterationName,
      experience.iterationId AS iterationId,
      experience.isControl AS isControl,
      experience.first_view_meta_ts AS first_view_meta_ts,
      experience.first_view_meta_recordDate AS first_view_meta_recordDate,
      experience.first_view_in_iteration AS first_view_in_iteration,
      experience.last_view_in_iteration AS last_view_in_iteration,
      experience.is_post_experience_view AS is_post_experience_view,
      experience.trafficAllocation AS trafficAllocation,
      experience.experience_status AS experience_status,
      experience.days_experience_live AS days_experience_live,
      experience.experience_first_published_at AS experience_first_published_at,
      experience.iteration_published_at AS iteration_published_at,
      experience.iteration_paused_at AS iteration_paused_at,
      experience.experience_last_paused_at AS experience_last_paused_at,
      experience.experience_paused_on_view AS experience_paused_on_view,
      experience.experience_paused_within_15_days AS experience_paused_within_15_days
    FROM
      `qubit-client-CLIENTPROJECTNUM.CLIENTNAME____v2.livetap_experience`
    LEFT JOIN
      UNNEST (experience) as experience
    WHERE
      ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
    )
SELECT
	CAST(q_experience_v01.iterationId AS STRING)  AS q_experience_v01_iteration_id,
	if (q_experience_v01.trafficAllocation is not null, CAST(q_experience_v01.trafficAllocation as NUMERIC), 1)  AS q_experience_v01_traffic_allocation,
	CAST(q_view_v01.property_event_ts  AS DATE) AS q_view_v01_time_data_points_date,
	COUNT(DISTINCT IF(q_transaction_v01.transaction_id IS NOT NULL,q_experience_v01.context_id,NULL))  AS q_experience_v01_experience_converters,
	COUNT(DISTINCT q_experience_v01.view_id)  AS q_experience_v01_experience_views,
	COUNT(DISTINCT IF(q_experience_v01.experienceId IS NOT NULL,q_experience_v01.context_id,NULL))   AS q_experience_v01_experience_visitors,
	COALESCE(ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE(CASE WHEN q_experience_v01.experienceId IS NOT NULL THEN q_transaction_v01.transaction_total END ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6), 0) AS q_experience_v01_transaction_total,
	COUNT(DISTINCT CASE WHEN q_experience_v01.experienceId IS NOT NULL THEN q_transaction_v01.transaction_id END)  AS q_experience_v01_transactions,
	SAFE_DIVIDE((COUNT(DISTINCT IF(q_transaction_v01.transaction_id IS NOT NULL,q_experience_v01.context_id,NULL))),COUNT(DISTINCT q_experience_v01.context_id))  AS q_experience_v01_visitor_conversion_rate
FROM `qubit-client-CLIENTPROJECTNUM.CLIENTNAME____v2.livetap_view`  AS q_view_v01
LEFT JOIN q_transaction_v01 ON q_view_v01.view_id  = q_transaction_v01.view_id
LEFT JOIN q_experience_v01 ON q_view_v01.view_id  = q_experience_v01.view_id

WHERE (((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY))))) AND ((UPPER(q_experience_v01.experienceName ) = UPPER('<<Experience Name>>'))) AND ((UPPER(CAST(q_experience_v01.iterationId AS STRING) ) = UPPER('304598'))) AND ((UPPER(q_experience_v01.variationName ) = UPPER('<<Iteration Name>>')))
GROUP BY 1,2,3
ORDER BY 3 DESC
