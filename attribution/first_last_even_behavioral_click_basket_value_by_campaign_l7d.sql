SELECT
	q_attribution_v01.referrer_campaign  AS q_attribution_v01_referrer_campaign,
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

WHERE
	(((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
GROUP BY 1
ORDER BY 2 DESC
LIMIT 500
