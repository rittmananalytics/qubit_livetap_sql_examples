SELECT
	q_attribution_v01.context_id  AS q_attribution_v01_context_id,
	q_attribution_v01.ranked_entry_number  AS q_attribution_v01_ranked_entry_number,
	FORMAT_TIMESTAMP('%F %T', q_attribution_v01.entry_timestamp ) AS q_attribution_v01_entry_timestamp_time,
	q_attribution_v01.ranked_purchase_number_int  AS q_attribution_v01_ranked_purchase_number_int,
	q_attribution_v01.touchpoint  AS q_attribution_v01_touchpoint,
	q_attribution_v01.order_ids_in_purchase_cycle  AS q_attribution_v01_order_ids_in_purchase_cycle,
	q_attribution_v01.true_referrer_type  AS q_attribution_v01_true_referrer_type,
	q_attribution_v01.referrer_type  AS q_attribution_v01_referrer_type,
	q_attribution_v01.referrer_adGroup  AS q_attribution_v01_referrer_ad_group,
	q_attribution_v01.referrer_campaign  AS q_attribution_v01_referrer_campaign,
	q_attribution_v01.referrer_content  AS q_attribution_v01_referrer_content,
	q_attribution_v01.referrer_domain  AS q_attribution_v01_referrer_domain,
	q_attribution_v01.referrer_keywords  AS q_attribution_v01_referrer_keywords,
	q_attribution_v01.referrer_label  AS q_attribution_v01_referrer_label,
	q_attribution_v01.referrer_matchType  AS q_attribution_v01_referrer_match_type,
	q_attribution_v01.referrer_mediaType  AS q_attribution_v01_referrer_media_type,
	q_attribution_v01.referrer_network  AS q_attribution_v01_referrer_network,
	q_attribution_v01.referrer_searchQuery  AS q_attribution_v01_referrer_search_query,
	SUM(q_attribution_v01.first_click_value / q_attribution_v01.pageviews_in_entry ) AS q_attribution_v01_first_click_value_livetap,
	SUM(q_attribution_v01.last_click_value / q_attribution_v01.pageviews_in_entry  ) AS q_attribution_v01_last_click_value_livetap,
	SUM(q_attribution_v01.even_click_value / q_attribution_v01.pageviews_in_entry ) AS q_attribution_v01_even_click_value_livetap,
	SUM(q_attribution_v01.behavioural_value /  q_attribution_v01.pageviews_in_entry)  AS q_attribution_v01_behavioural_value_livetap
FROM `qubit-client-CLIENTPROJECTNUM.PROJECTNAME__v2.livetap_view`  AS q_view_v01
LEFT JOIN `qubit-client-CLIENTPROJECTNUM.PROJECTNAME__v2.livetap_attribution`  AS q_attribution_v01 ON (q_attribution_v01.context_id = q_view_v01.context_id
              AND q_attribution_v01.context_sessionNumber = q_view_v01.context_sessionNumber
              AND q_attribution_v01.context_entranceNumber = q_view_v01.context_entranceNumber
              AND q_attribution_v01.context_conversionNumber = q_view_v01.context_conversionNumber
              )

WHERE (((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY))))) AND ((UPPER(q_attribution_v01.context_id ) = UPPER('rclccp56kqo-0kbwm35ud-lzvrc40')))
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
ORDER BY 2
LIMIT 500
