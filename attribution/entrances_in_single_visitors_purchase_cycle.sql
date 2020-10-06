SELECT
	q_attribution_v01.context_id  AS q_attribution_v01_context_id,
	q_attribution_v01.ranked_entry_number  AS q_attribution_v01_ranked_entry_number,
	q_attribution_v01.context_entranceNumber  AS q_attribution_v01_context_entrance_number,
	FORMAT_TIMESTAMP('%F %T', q_attribution_v01.entry_timestamp ) AS q_attribution_v01_entry_timestamp_time,
	q_attribution_v01.ranked_purchase_number_int  AS q_attribution_v01_ranked_purchase_number_int,
	q_attribution_v01.context_sessionNumber  AS q_attribution_v01_context_session_number,
	q_attribution_v01.touchpoint  AS q_attribution_v01_touchpoint,
	q_attribution_v01.pageviews_in_entry  AS q_attribution_v01_view_count,
	q_attribution_v01.entries_in_purchase_cycle  AS q_attribution_v01_entries_in_purchase_cycle,
	q_attribution_v01.order_ids_in_purchase_cycle  AS q_attribution_v01_order_ids_in_purchase_cycle,
	SUM(q_attribution_v01.first_click_value / q_attribution_v01.pageviews_in_entry ) AS q_attribution_v01_first_click_value_livetap,
	SUM(q_attribution_v01.last_click_value / q_attribution_v01.pageviews_in_entry  ) AS q_attribution_v01_last_click_value_livetap,
	SUM(q_attribution_v01.even_click_value / q_attribution_v01.pageviews_in_entry ) AS q_attribution_v01_even_click_value_livetap,
	SUM(q_attribution_v01.behavioural_value /  q_attribution_v01.pageviews_in_entry)  AS q_attribution_v01_behavioural_value_livetap
FROM `qubit-client-37040.halfords_uk_prod__v2____v2.livetap_view`  AS q_view_v01
LEFT JOIN `qubit-client-37040.halfords_uk_prod__v2____v2.livetap_attribution`  AS q_attribution_v01 ON (q_attribution_v01.context_id = q_view_v01.context_id
              AND q_attribution_v01.context_sessionNumber = q_view_v01.context_sessionNumber
              AND q_attribution_v01.context_entranceNumber = q_view_v01.context_entranceNumber
              AND q_attribution_v01.context_conversionNumber = q_view_v01.context_conversionNumber
              )
WHERE (((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY))))) AND ((UPPER(q_attribution_v01.context_id ) = UPPER('rclccp56kqo-0kbwm35ud-lzvrc40')))
GROUP BY 1,2,3,4,5,6,7,8,9,10
ORDER BY 1,2,3,4,5,6 DESC
