WITH q_transaction_v01 AS (SELECT
        *
      FROM
        `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_transaction`
      WHERE
        ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
      )
  ,  transaction_sequence AS (WITH view AS (SELECT
        * EXCEPT(event_number)
      FROM
        (SELECT
          TIMESTAMP_ADD(meta_serverTs, INTERVAL 0 MICROSECOND) AS property_event_ts,
          meta_recordDate,
          CONCAT(IFNULL(CAST(context_id AS STRING),
              '-'),IFNULL(CAST('-' AS STRING),
              '-'),IFNULL(CAST(context_viewNumber AS STRING),
              '-')) AS view_id,
          CONCAT(IFNULL(CAST(context_id AS STRING),
              '-'),IFNULL(CAST('-' AS STRING),
              '-'),IFNULL(CAST(context_sessionNumber AS STRING),
              '-')) AS session_id,
        CONCAT(IFNULL(CAST(context_id AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(context_entranceNumber AS STRING),
            '-')) AS entrance_id,
          context_id,
          type,
          MAX(FORMAT_TIMESTAMP('%F %H:%M', TIMESTAMP_TRUNC(TIMESTAMP_SECONDS((UNIX_SECONDS(meta_serverTs ) - MOD(UNIX_SECONDS(meta_serverTs ), (60*5)))), MINUTE))) OVER (PARTITION BY DATE(meta_serverTs)) AS last_minute5_interval,
          -- deduplicate by getting first chronological view from a set of duplicates
          ROW_NUMBER() OVER (PARTITION BY context_id, context_viewNumber ORDER BY meta_serverTs ASC) as event_number
        FROM
          `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.event_ecView`
        WHERE
          context_id IS NOT NULL
          AND context_viewNumber IS NOT NULL
          AND context_sessionNumber IS NOT NULL
          AND context_entranceNumber IS NOT NULL
         )
      WHERE
        event_number = 1
    )
  ,  transaction AS (SELECT
        TIMESTAMP_ADD(meta_serverTs, INTERVAL 0 MICROSECOND) AS property_event_ts,
        transaction_id,
        context_id,
        basket_total_baseValue,
        basket_quantity,
        CONCAT(IFNULL(CAST(context_id AS STRING),
          '-'),IFNULL(CAST('-' AS STRING),
          '-'),IFNULL(CAST(context_viewNumber AS STRING),
          '-')) AS view_id,
        CONCAT(IFNULL(CAST(context_id AS STRING),
          '-'),IFNULL(CAST('-' AS STRING),
          '-'),IFNULL(CAST(context_viewNumber AS STRING),
          '-'),IFNULL(CAST('-' AS STRING),
          '-'),IFNULL(CAST(transaction_id AS STRING),
          '-'))
          AS view_transaction_id,
        CONCAT(IFNULL(CAST(context_id AS STRING),
          '-'),IFNULL(CAST('-' AS STRING),
          '-'),IFNULL(CAST(context_sessionNumber AS STRING),
          '-')) AS session_id
      FROM
        `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.event_ecBasketTransactionSummary`
    )
SELECT
  views.view_id as view_id,
  views.context_id as context_id,
  transaction.view_transaction_id as view_transaction_id,
  transaction.transaction_id  AS transaction_id,
  transaction.property_event_ts
  row_number() over (partition by views.context_id order by transaction.property_event_ts) as visitor_transaction_purchase_cycle
FROM view AS views
LEFT JOIN transaction ON views.view_id = transaction.view_id

WHERE transaction_id is not null
GROUP BY 1,2,3,4,5,6,7

ORDER BY 1
 )
SELECT
	transaction_sequence.visitor_transaction_purchase_cycle  AS converter_transaction_purchase_cycle,
	FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(timestamp(q_view_v01.visitor_first_entry_date) , WEEK(MONDAY))) AS visitor_first_entry_week,
	q_transaction_v01.basket_total_baseValue  AS q_transaction_v01_basket_total_base_value
FROM `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_view`  AS q_view_v01
LEFT JOIN q_transaction_v01 ON q_view_v01.view_id  = q_transaction_v01.view_id
INNER JOIN transaction_sequence ON q_transaction_v01.transaction_id = transaction_sequence.transaction_id
        and q_transaction_v01.view_id = transaction_sequence.view_id
        and q_transaction_v01.context_id = transaction_sequence.context_id

WHERE
	(((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
GROUP BY 1,2,3
ORDER BY 2 DESC
