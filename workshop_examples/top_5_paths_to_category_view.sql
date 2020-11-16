WITH
  category_view_events AS (
  SELECT
    q_view_v01.context_id AS context_id,
    q_view_v01.context_viewNumber AS view_number,
    q_view_v01.meta_url,
    CASE
      WHEN q_view_v01.page_subtype = 'Bike Accessories' THEN q_view_v01.context_viewNumber
  END
    AS target_viewNumber,
    q_view_v01.view_id AS view_id,
    q_view_v01.page_subtype AS q_view_v01_page_subtype
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAM__v2.livetap_view` AS q_view_v01
  WHERE
    (((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY)))
        AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY), INTERVAL 90 DAY)))))),
  category_view_events_with_target AS (
  SELECT
    * EXCEPT (target_viewNumber,
      view_id),
    MIN(target_viewNumber) OVER (PARTITION BY context_id) AS target_viewNumber
  FROM
    category_view_events ),
five_events_to_conversion as (
select * from (
SELECT
  target_viewNumber - view_number conversion_index,
  * EXCEPT (target_viewNumber)
FROM
  category_view_events_with_target
WHERE
  view_number <= target_viewNumber

ORDER BY
  context_id,
  view_number,
  meta_url)
where conversion_index <= 5),
pivoted as
(
select
  context_id,
  max(case when conversion_index = 0 then meta_url end) as step_0,
  max(case when conversion_index = 1 then meta_url end) as step_1,
  max(case when conversion_index = 2 then meta_url end) as step_2,
  max(case when conversion_index = 3 then meta_url end) as step_3,
  max(case when conversion_index = 4 then meta_url end) as step_4,
  max(case when conversion_index = 5 then meta_url end) as step_5
from five_events_to_conversion
group by 1
limit 500
)
select count(*), step_1, step_2, step_3, step_4, step_5
from pivoted
group by 2,3,4,5,6
order by 1 desc
