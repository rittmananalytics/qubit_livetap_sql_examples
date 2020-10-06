SELECT
	FORMAT_TIMESTAMP('%F %T', q_view_v01.property_event_ts ) AS q_view_v01_time_data_points_time,
	q_view_v01.context_viewNumber  AS q_view_v01_context_view_number,
	q_view_v01.context_sessionNumber  AS q_view_v01_context_session_number,
	q_view_v01.context_sessionViewNumber  AS q_view_v01_context_session_view_number,
	q_view_v01.meta_url  AS q_view_v01_meta_url,
	q_view_v01.page_subtype  AS q_view_v01_page_subtype
FROM `qubit-client-CLIENTPROJECTNUM.PROJECTNAME__v2.livetap_view`  AS q_view_v01

WHERE ((UPPER(q_view_v01.context_id ) = UPPER('7k13x3g78m4-0kdq6l42v-slqbkzk')))
GROUP BY 1,2,3,4,5,6
ORDER BY 1,2,3,4
LIMIT 500
