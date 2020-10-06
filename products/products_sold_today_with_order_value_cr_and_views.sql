WITH view AS (WITH View as (SELECT
          TIMESTAMP_ADD(meta_serverTs, INTERVAL 1 HOUR) AS property_event_ts,
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
 MAX(FORMAT_TIMESTAMP('%F %H:%M', TIMESTAMP_TRUNC(TIMESTAMP_SECONDS((UNIX_SECONDS(TIMESTAMP_ADD(meta_serverTs, INTERVAL 3600000000 MICROSECOND) ) - MOD(UNIX_SECONDS(TIMESTAMP_ADD(meta_serverTs, INTERVAL 3600000000 MICROSECOND) ), (60*5)))), MINUTE))) OVER (PARTITION BY DATE(meta_serverTs)) AS last_minute5_interval,
 MAX(FORMAT_TIMESTAMP('%F %H:%M', TIMESTAMP_TRUNC(TIMESTAMP_SECONDS((UNIX_SECONDS(TIMESTAMP_ADD(meta_serverTs, INTERVAL 3600000000 MICROSECOND) ) - MOD(UNIX_SECONDS(TIMESTAMP_ADD(meta_serverTs, INTERVAL 3600000000 MICROSECOND) ), (60*60)))), MINUTE))) OVER (PARTITION BY DATE(meta_serverTs)) AS last_minute60_interval,

-- deduplicate by getting first chronological view from a set of duplicates
          concat(concat(concat(concat(concat (concat (concat(coalesce(JSON_EXTRACT_SCALAR(subtypes,'$[1]'),''),', '),coalesce(JSON_EXTRACT_SCALAR(subtypes,'$[2]'),''),', '),coalesce(JSON_EXTRACT_SCALAR(subtypes,'$[3]'),''),', ')),coalesce(JSON_EXTRACT_SCALAR(subtypes,'$[4]'),'')),coalesce(JSON_EXTRACT_SCALAR(subtypes,'$[5]'),''))) as breadcrumbs,
          JSON_EXTRACT_SCALAR(subtypes,'$[0]') as sub_type, --page_category_lvl_1,
          JSON_EXTRACT_SCALAR(subtypes,'$[1]') as page_category_lvl_2,
          JSON_EXTRACT_SCALAR(subtypes,'$[2]') as page_category_lvl_3,
          JSON_EXTRACT_SCALAR(subtypes,'$[3]') as page_category_lvl_4,
          case when JSON_EXTRACT_SCALAR(subtypes,'$[0]') in ('Car Servicing', 'Car Repairs', 'MOT', 'Tyres') then 'autocentre' else 'retail' end as brand,
          ROW_NUMBER() OVER (PARTITION BY context_id, context_viewNumber ORDER BY meta_serverTs ASC) as event_number,
          meta_url
        FROM
          `qubit-client-37040.halfords_uk_prod__v2____v2.event_ecView`
        WHERE
          --((( meta_serverTs ) >= ((TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY))) AND ( meta_serverTs ) < ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL 1 DAY)))))
      (TIMESTAMP_ADD(meta_serverTs, INTERVAL 1 HOUR)  >= TIMESTAMP_TRUNC( TIMESTAMP_ADD(current_timestamp, INTERVAL 1 HOUR) , DAY) )
      AND (TIMESTAMP_ADD(meta_serverTs, INTERVAL 1 HOUR)  < (TIMESTAMP_ADD( TIMESTAMP_TRUNC( TIMESTAMP_ADD( current_timestamp, INTERVAL 1 HOUR) ,DAY) , INTERVAL 1 DAY) )

          AND context_id IS NOT NULL
          AND context_viewNumber IS NOT NULL
          AND context_sessionNumber IS NOT NULL
          AND context_entranceNumber IS NOT NULL
         ))
SELECT
        * EXCEPT(x)
      FROM
        View
      LEFT JOIN (
        SELECT
            View.session_id as x,
            STRING_AGG(DISTINCT View.brand, ":" ORDER BY View.brand DESC LIMIT 2) as product_manufacturer
            FROM View
            GROUP BY View.session_id
        ) as p ON p.x = View.session_id
      WHERE
        event_number = 1
    )
  ,  product AS (SELECT
        *
      FROM
        (SELECT
          TIMESTAMP_ADD(meta_serverTs, INTERVAL 3600000000 MICROSECOND) AS property_event_ts,
          transaction_id,
          product_sku,
          product_name,
          product_manufacturer,
          product_price_baseValue,
          quantity,
          CONCAT(IFNULL(CAST(context_id AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(context_viewNumber AS STRING),
            '-')) AS view_id,
          CONCAT(IFNULL(CAST(context_id AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(context_viewNumber AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(meta_type AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(product_sku AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(product_productId AS STRING),
            '-')) AS product_transaction_id,
          meta_type
        FROM
          `qubit-client-37040.halfords_uk_prod__v2____v2.event_ecBasketItemTransaction`
        WHERE
           TIMESTAMP_ADD(meta_serverTs, INTERVAL 3600000000 MICROSECOND) >= TIMESTAMP_TRUNC(TIMESTAMP_ADD(current_timestamp,INTERVAL 3600000000 MICROSECOND) ,DAY)
        --  ((( meta_serverTs ) >= ((TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY))) AND ( meta_serverTs ) < ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL 1 DAY)))))
        UNION ALL
        SELECT
          TIMESTAMP_ADD(meta_serverTs, INTERVAL 0 MICROSECOND) AS property_event_ts,
          NULL AS transaction_id,
          product_productId AS product_sku,
          product_name,
          product_manufacturer,
          NULL AS product_price_baseValue,
          NULL AS quantity,
          CONCAT(IFNULL(CAST(context_id AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(context_viewNumber AS STRING),
            '-')) AS view_id,
          CONCAT(IFNULL(CAST(context_id AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(context_viewNumber AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(meta_type AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(product_sku AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(product_productId AS STRING),
            '-')) AS product_transaction_id,
          meta_type
        FROM
          `qubit-client-37040.halfords_uk_prod__v2____v2.event_ecProduct`
        WHERE
         TIMESTAMP_ADD(meta_serverTs, INTERVAL 3600000000 MICROSECOND) >= TIMESTAMP_TRUNC(TIMESTAMP_ADD(current_timestamp,INTERVAL 3600000000 MICROSECOND) ,DAY)
          --((( meta_serverTs ) >= ((TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY))) AND ( meta_serverTs ) < ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL 1 DAY)))))
        UNION ALL
        SELECT
          TIMESTAMP_ADD(meta_serverTs, INTERVAL 0 MICROSECOND) AS property_event_ts,
          NULL AS transaction_id,
          product_productId AS product_sku,
          product_name,
          product_manufacturer,
          NULL AS product_price_baseValue,
          NULL AS quantity,
          CONCAT(IFNULL(CAST(context_id AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(context_viewNumber AS STRING),
            '-')) AS view_id,
          CONCAT(IFNULL(CAST(context_id AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(context_viewNumber AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(meta_type AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(product_sku AS STRING),
            '-'),IFNULL(CAST('-' AS STRING),
            '-'),IFNULL(CAST(product_productId AS STRING),
            '-')) AS product_transaction_id,
          meta_type
        FROM
          `qubit-client-37040.halfords_uk_prod__v2____v2.event_ecBasketItem`
        WHERE
          TIMESTAMP_ADD(meta_serverTs, INTERVAL 3600000000 MICROSECOND) >= TIMESTAMP_TRUNC(TIMESTAMP_ADD(current_timestamp,INTERVAL 3600000000 MICROSECOND) ,DAY)
          --((( meta_serverTs ) >= ((TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY))) AND ( meta_serverTs ) < ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL 1 DAY)))))
        )
    )
SELECT
	product.product_sku  AS product_product_sku,
	product.product_name  AS product_product_name,
	COALESCE(ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE(IF(product.transaction_id IS NOT NULL, product.quantity, NULL),0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST(product.product_transaction_id  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(product.product_transaction_id  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST(product.product_transaction_id  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(product.product_transaction_id  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6), 0) AS product_product_quantity_sum,
	COALESCE(ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE(IF(product.transaction_id IS NOT NULL, product.product_price_baseValue ,0) ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST(product.product_transaction_id  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(product.product_transaction_id  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST(product.product_transaction_id  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(product.product_transaction_id  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6), 0) AS product_product_purchased_value,
	SUM(product.quantity) / NULLIF((COUNT(DISTINCT(IF(product.meta_type LIKE '%ecProduct', product.view_id,NULL)))), 0)  AS product_product_conversion_rate,
	COUNT(DISTINCT(IF(product.meta_type LIKE '%ecProduct', product.view_id,NULL))) AS product_product_views
FROM view AS realtime
LEFT JOIN product ON realtime.view_id = product.view_id

WHERE
	(((realtime.property_event_ts ) >= ((TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY))) AND (realtime.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL 1 DAY)))))
GROUP BY 1,2
ORDER BY 4 DESC
LIMIT 500
