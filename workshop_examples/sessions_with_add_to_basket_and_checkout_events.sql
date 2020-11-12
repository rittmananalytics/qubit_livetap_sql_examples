WITH q_session_v01_add_to_basket AS (SELECT
        *
      FROM
        `qubit-client-37040.halfords_uk_prod__v2.livetap_session`
      WHERE
        ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY), INTERVAL 90 DAY)))))
      )
  ,  q_product_v01_add_to_basket AS (SELECT
          property_event_ts,
          view_id,
          session_id,
          context_id,
          context_viewNumber,
          context_sessionNumber,
          product.product_interaction_type product_interaction_type
        FROM
          `qubit-client-37040.halfords_uk_prod__v2.livetap_product` v
        LEFT JOIN
          UNNEST (product) AS product
        WHERE
          ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY), INTERVAL 90 DAY)))))
        ),
    add_to_basket_events as (
SELECT
	q_product_v01_add_to_basket.product_interaction_type  AS first_product_interaction_type,
	q_view_v01.property_event_ts AS first_time,
	q_view_v01.page_subtype  AS first_page_subtype,
	q_session_v01_add_to_basket.session_id as first_session_id
FROM `qubit-client-37040.halfords_uk_prod__v2.livetap_view`  AS q_view_v01
LEFT JOIN q_session_v01_add_to_basket ON q_session_v01_add_to_basket.session_id = q_view_v01.session_id
LEFT JOIN q_product_v01_add_to_basket ON q_product_v01_add_to_basket.view_id = q_view_v01.view_id
WHERE (((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY), INTERVAL 90 DAY))))) AND ((UPPER(q_product_v01_add_to_basket.product_interaction_type ) = UPPER('View with Product in Basket')))
GROUP BY 1,2,3,4),
	q_session_v01_checkout AS (SELECT
        *
      FROM
        `qubit-client-37040.halfords_uk_prod__v2.livetap_session`
      WHERE
        ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY), INTERVAL 90 DAY)))))
      )
  ,  q_product_v01_checkout AS (SELECT
          property_event_ts,
          view_id,
          session_id,
          context_id,
          context_viewNumber,
          context_sessionNumber,
          product.product_interaction_type product_interaction_type
        FROM
          `qubit-client-37040.halfords_uk_prod__v2.livetap_product` v
        LEFT JOIN
          UNNEST (product) AS product
        WHERE
          ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY), INTERVAL 90 DAY)))))
        ),
    checkout_events as (
SELECT
	q_product_v01_checkout.product_interaction_type  AS second_product_interaction_type,
	q_view_v01.property_event_ts  AS second_time,
	q_view_v01.page_subtype  AS second_page_subtype,
	q_session_v01_checkout.session_id as second_session_id
FROM `qubit-client-37040.halfords_uk_prod__v2.livetap_view`  AS q_view_v01
LEFT JOIN q_session_v01_checkout ON q_session_v01_checkout.session_id = q_view_v01.session_id
LEFT JOIN q_product_v01_checkout ON q_product_v01_checkout.view_id = q_view_v01.view_id
WHERE (((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY), INTERVAL 90 DAY))))) AND ((UPPER(q_product_v01_checkout.product_interaction_type ) = UPPER('Product Purchase')))
GROUP BY 1,2,3,4)
SELECT first_product_interaction_type,
	   first_time,
	   first_page_subtype,
	   first_session_id,
	   second_product_interaction_type,
	   second_time,
	   second_page_subtype,
	   second_session_id,
     timestamp_diff(second_time,first_time,second) as seconds_to_purchase
from   add_to_basket_events
join   checkout_events
on     add_to_basket_events.first_session_id = checkout_events.second_session_id
limit 500
