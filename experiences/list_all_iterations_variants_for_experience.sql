WITH q_experience_v01 AS (SELECT
      experience.experienceId AS experienceId,
      experience.experienceName AS experienceName,
      experience.variationMasterId AS variationMasterId,
      experience.variationName AS variationName,
      experience.iterationName AS iterationName,
      experience.iterationId AS iterationId,
      experience.isControl AS isControl,
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
      `qubit-client-CLIENTPROJECTNUM.PROJECTNAME__v2.livetap_experience`
    LEFT JOIN
      UNNEST (experience) as experience
    WHERE
      ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
    )
SELECT
	CAST(q_experience_v01.experienceId AS STRING)  AS experience_id,
	q_experience_v01.experienceName  AS experience_name
FROM q_experience_v01
