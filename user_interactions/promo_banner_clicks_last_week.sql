WITH q_user_action_v01 AS (SELECT
          qp_bi_view_name,
          ts,
          property_event_ts,
          view_id,
          meta_recordDate,
          meta_trackingId,
          context_id,
          context_viewNumber,
          context_sessionNumber,
          meta_serverTs,
          meta_ts,
          user_action.meta_type AS meta_type,
          user_action.type AS type,
          user_action.name AS name,
          user_action.user_interaction_type AS user_interaction_type,
          user_action.voucher_id AS voucher_id,
          user_action.voucher_label AS voucher_label,
          user_action.voucher_entry AS voucher_entry,
          user_action.voucher_entrySuccess AS voucher_entrySuccess
        FROM
          `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_user_action`
        LEFT JOIN
          unnest (user_action) as user_action
        WHERE
          ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY), INTERVAL 28 DAY)))))
        )
SELECT
	q_user_action_v01.name  AS q_user_action_v01_name,
	FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(q_view_v01.property_event_ts , WEEK(SUNDAY))) AS q_view_v01_time_data_points_week,
	COUNT(DISTINCT q_user_action_v01.view_id)  AS q_user_action_v01_total_visitor_views
FROM `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_view`  AS q_view_v01
LEFT JOIN q_user_action_v01 ON q_view_v01.view_id  = q_user_action_v01.view_id

WHERE (((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY), INTERVAL 28 DAY))))) AND ((UPPER(q_user_action_v01.name ) LIKE UPPER('%PromoBanner%'))) AND ((UPPER(q_user_action_v01.meta_type ) = UPPER('menards.ecInteraction')))
GROUP BY 1,2
ORDER BY 3 DESC,2
LIMIT 500
