WITH
  category_view_events AS (
  SELECT
    q_view_v01.context_id AS context_id,
    q_view_v01.context_viewNumber AS view_number,
    CASE
      WHEN q_view_v01.page_subtype = 'Bike Accessories' THEN q_view_v01.context_viewNumber
  END
    AS target_viewNumber,
    q_view_v01.view_id AS view_id,
    q_view_v01.page_subtype AS q_view_v01_page_subtype
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_view` AS q_view_v01
  WHERE
    (((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY)))
        AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY), INTERVAL 90 DAY)))))),
  category_view_events_with_target AS (
  SELECT
    * EXCEPT (target_viewNumber,
      view_id),
    MIN(target_viewNumber) OVER (PARTITION BY context_id) AS target_viewNumber
  FROM
    category_view_events )
SELECT
  * EXCEPT (target_viewNumber)
FROM
  category_view_events_with_target
WHERE
  view_number <= target_viewNumber
ORDER BY
  context_id,
  view_number
LIMIT
  500
