WITH q_transaction_v01 AS (SELECT
        *
      FROM
        `qubit-client-CLIENTPROJECTNUM.PROJECTNAME__v2.livetap_transaction`
      WHERE
        ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
      )
  ,  q_experience_v01 AS (SELECT
      view_id,
      meta_recordDate
      context_id,
      meta_serverTs,
      experience.experienceId AS experienceId,
      experience.experienceName AS experienceName,
      experience.variationMasterId AS variationMasterId,
      experience.variationName AS variationName,
      experience.iterationName AS iterationName,
      experience.iterationId AS iterationId,
      experience.isControl AS isControl,
      experience.trafficAllocation AS trafficAllocation,
      experience.experience_status AS experience_status
    FROM
      `qubit-client-CLIENTPROJECTNUM.PROJECTNAME__v2.livetap_experience`
    LEFT JOIN
      UNNEST (experience) as experience
    WHERE
      ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
    )
SELECT
	CAST(q_experience_v01.iterationId AS STRING)  AS iteration_id,
	if (q_experience_v01.trafficAllocation is not null, CAST(q_experience_v01.trafficAllocation as NUMERIC), 1)  AS traffic_allocation,
	CAST(q_view_v01.property_event_ts  AS DATE) AS date,
	COUNT(DISTINCT IF(q_transaction_v01.transaction_id IS NOT NULL,q_experience_v01.context_id,NULL))  AS experience_converters,
	COUNT(DISTINCT q_experience_v01.view_id)  AS experience_views,
	COUNT(DISTINCT IF(q_experience_v01.experienceId IS NOT NULL,q_experience_v01.context_id,NULL))   AS experience_visitors,
	COUNT(DISTINCT CASE WHEN q_experience_v01.experienceId IS NOT NULL THEN q_transaction_v01.transaction_id END)  AS transactions,
	SAFE_DIVIDE((COUNT(DISTINCT IF(q_transaction_v01.transaction_id IS NOT NULL,q_experience_v01.context_id,NULL))),COUNT(DISTINCT q_experience_v01.context_id))  AS visitor_conversion_rate
FROM `qubit-client-CLIENTPROJECTNUM.PROJECTNAME__v2.livetap_view`  AS q_view_v01
LEFT JOIN q_transaction_v01 ON q_view_v01.view_id  = q_transaction_v01.view_id
LEFT JOIN q_experience_v01 ON q_view_v01.view_id  = q_experience_v01.view_id

WHERE (((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY))))) AND ((UPPER(q_experience_v01.experienceName ) = UPPER('<<Experience Name>>'))) AND ((UPPER(CAST(q_experience_v01.iterationId AS STRING) ) = UPPER('304598'))) AND ((UPPER(q_experience_v01.variationName ) = UPPER('<<Iteration Name>>')))
GROUP BY 1,2,3
ORDER BY 3 DESC
