WITH
  lockdown_sessions AS (
  SELECT
    'First UK Lockdown' AS period,
    *
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_session`
  WHERE
    ((( property_event_ts ) >= (TIMESTAMP('2020-03-23 00:00:00'))
        AND ( property_event_ts ) < (TIMESTAMP('2020-05-10 00:00:00')))) ),
  pre_lockdown_sessions AS (
  SELECT
    '7 Weeks Priod to First UK Lockdown' AS period,
    *
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_session`
  WHERE
    ((( property_event_ts ) >= (TIMESTAMP('2020-02-10 00:00:00'))
        AND ( property_event_ts ) < (TIMESTAMP('2020-03-22 00:00:00')))) ),
  yago_lockdown_period_sessions AS (
  SELECT
    'UK Lockdown Period Year Ago' AS period,
    *
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_session`
  WHERE
    ((( property_event_ts ) >= (TIMESTAMP('2019-03-24 00:00:00'))
        AND ( property_event_ts ) < (TIMESTAMP('2019-05-11 00:00:00')))) ),
  combined_periods AS (
  SELECT
    period,
    EXTRACT(HOUR
    FROM
      q_view_v01.property_event_ts ) AS hour_of_day,
    COUNT(DISTINCT lockdown_sessions.session_id) AS sessions
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_view` AS q_view_v01
  LEFT JOIN
    lockdown_sessions
  ON
    lockdown_sessions.session_id = q_view_v01.session_id
  WHERE
    (((q_view_v01.property_event_ts ) >= (TIMESTAMP('2020-03-23 00:00:00'))
        AND (q_view_v01.property_event_ts ) < (TIMESTAMP('2020-05-10 00:00:00'))))
  GROUP BY
    1,
    2
  UNION ALL
  SELECT
    period,
    EXTRACT(HOUR
    FROM
      q_view_v01.property_event_ts ) AS hour_of_day,
    COUNT(DISTINCT pre_lockdown_sessions.session_id) AS sessions
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_view` AS q_view_v01
  LEFT JOIN
    pre_lockdown_sessions
  ON
    pre_lockdown_sessions.session_id = q_view_v01.session_id
  WHERE
    (((q_view_v01.property_event_ts ) >= (TIMESTAMP('2020-02-10 00:00:00'))
        AND (q_view_v01.property_event_ts ) < (TIMESTAMP('2020-03-22 00:00:00'))))
  GROUP BY
    1,
    2
  UNION ALL
  SELECT
    period,
    EXTRACT(HOUR
    FROM
      q_view_v01.property_event_ts ) AS hour_of_day,
    COUNT(DISTINCT yago_lockdown_period_sessions.session_id) AS sessions
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_view` AS q_view_v01
  LEFT JOIN
    yago_lockdown_period_sessions
  ON
    yago_lockdown_period_sessions.session_id = q_view_v01.session_id
  WHERE
    (((q_view_v01.property_event_ts ) >= (TIMESTAMP('2019-03-24 00:00:00'))
        AND (q_view_v01.property_event_ts ) < (TIMESTAMP('2019-05-11 00:00:00'))))
  GROUP BY
    1,
    2)
SELECT
  hour_of_day,
  period,
  sessions
FROM
  combined_periods
WHERE
  period IS NOT NULL
ORDER BY
  hour_of_day,
  period
