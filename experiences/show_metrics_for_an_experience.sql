WITH
  q_transaction_v01 AS (
  SELECT
    *
  FROM
    `qubit-client-37040.halfords_uk_prod__v2____v2.livetap_transaction`
  WHERE
    ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY)))
        AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY))))) ),
  q_experience_v01 AS (
  SELECT
    context_id,
    view_id,
    meta_recordDate,
    experience.experienceId AS experienceId,
    experience.experienceName AS experienceName,
    experience.variationName AS variationName,
    experience.iterationId AS iterationId,
    experience.iterationName AS iterationName,
    experience.isControl AS isControl,
    experience.trafficAllocation AS trafficAllocation,
    experience.experience_status AS experience_status,
    experience.experience_first_published_at AS experience_first_published_at,
    experience.iteration_paused_at AS iteration_paused_at,
  FROM
    `qubit-client-37040.halfords_uk_prod__v2____v2.livetap_experience`
  LEFT JOIN
    UNNEST (experience) AS experience
  WHERE
    ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY)))
        AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY))))) )
SELECT
  CAST(q_experience_v01.iterationName AS STRING) AS iterationName,
  CAST(TIMESTAMP(q_experience_v01.iteration_paused_at) AS DATE) AS iteration_paused_at,
  q_experience_v01.iterationId AS iteration_id,
  SAFE_CAST(q_experience_v01.trafficAllocation AS NUMERIC) AS traffic_allocation,
  q_experience_v01.variationName AS variation_name,
  COUNT(DISTINCT
  IF
    (q_experience_v01.experience_status = 'Live'
      AND CAST(q_experience_v01.meta_recordDate AS string) >= q_experience_v01.experience_first_published_at,
      q_experience_v01.meta_recordDate,
      NULL) ) AS days_experience_live,
  COUNT(DISTINCT
  IF
    (q_transaction_v01.transaction_id IS NOT NULL,
      q_experience_v01.context_id,
      NULL)) AS experience_converters,
  COUNT(DISTINCT q_experience_v01.view_id) AS experience_views,
  COUNT(DISTINCT
  IF
    (q_experience_v01.experienceId IS NOT NULL,
      q_experience_v01.context_id,
      NULL)) AS experience_visitors
FROM
  `qubit-client-37040.halfords_uk_prod__v2____v2.livetap_view` AS q_view_v01
LEFT JOIN
  q_transaction_v01
ON
  q_view_v01.view_id = q_transaction_v01.view_id
LEFT JOIN
  q_experience_v01
ON
  q_view_v01.view_id = q_experience_v01.view_id
WHERE
  (((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY)))
      AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
  AND ((UPPER(q_experience_v01.experienceName ) = UPPER('<<Experience Name>>')))
GROUP BY
  1,  2,  3,  4,  5ORDER BY
  1,
  2,
  3
