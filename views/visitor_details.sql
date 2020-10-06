SELECT
	q_view_v01.context_id  AS q_view_v01_context_id,
	q_view_v01.user_id  AS q_view_v01_user_id,
	q_view_v01.user_email  AS q_view_v01_user_email,
	q_view_v01.total_visitor_views  AS q_view_v01_total_visitor_views,
	IF(q_view_v01.context_conversionNumber IS NOT NULL, IF(q_view_v01.context_conversionNumber > 0, "yes", "no" ), NULL) AS q_view_v01_returning_purchaser_yesno,
	q_view_v01.new_vs_returning  AS q_view_v01_new_vs_returning,
	CAST(q_view_v01.visitor_first_entry_date  AS DATE) AS q_view_v01_visitor_first_entry_date,
	q_view_v01.context_lifetimeValue_baseValue  AS q_view_v01_context_lifetime_value_base_value,
	q_view_v01.context_conversionNumber  AS q_view_v01_context_conversion_number,
	q_view_v01.user_loyalty_tier  AS q_view_v01_user_loyalty_tier
FROM `qubit-client-37040.halfords_uk_prod__v2.livetap_view`  AS q_view_v01

WHERE
	(((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
GROUP BY 1,2,3,4,5,6,7,8,9,10
