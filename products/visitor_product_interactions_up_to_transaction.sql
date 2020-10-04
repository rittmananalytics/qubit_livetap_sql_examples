WITH q_transaction_v01 AS (SELECT
        *
      FROM
        `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_transaction`
      WHERE
        ((( property_event_ts ) >= ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -6 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))))) AND ( property_event_ts ) < ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -6 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS DATE), INTERVAL 7 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -6 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP)) AS STRING)))))))
      )
  ,  q_product_v01 AS (SELECT
          meta_recordDate,
          ts,
          property_event_ts,
          view_id,
          session_id,
          entrance_id,
          meta_serverTs,
          meta_ts,
          meta_trackingId,
          context_id,
          context_viewNumber,
          context_sessionNumber,
          context_conversionNumber,
          transaction_id,
          product_rows,
          product.concat_product_id product_concat_product_id,
          product.product_productId  product_productId,
          product.product_sku  product_sku,
          product.product_category product_category,
          product.product_subcategory product_subcategory,
          product.product_manufacturer product_manufacturer,
          product.product_color  product_color,
          product.product_size product_size,
          product.product_stock  product_stock,
          product.product_rating  product_rating,
          product.product_price_baseValue  product_price_baseValue,
          product.product_originalPrice_baseValue product_originalPrice_baseValue,
          product.product_price_baseCurrency product_price_baseCurrency,
          product.product_name product_name,
          product.product_basket_action product_basket_action,
          product.subtotal_baseValue subtotal_baseValue,
          product.quantity quantity,
          product.unique_row_id unique_row_id,
          product.product_interaction_type product_interaction_type,
          product.meta_type meta_type
        FROM
          `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_product` v
        LEFT JOIN
          UNNEST (product) AS product
        WHERE
          ((( property_event_ts ) >= ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -6 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))))) AND ( property_event_ts ) < ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -6 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS DATE), INTERVAL 7 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -6 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP)) AS STRING)))))))
        )
SELECT
	q_view_v01.context_id  AS q_view_v01_context_id,
	q_view_v01.context_viewNumber  AS q_view_v01_context_view_number,
	q_view_v01.context_sessionNumber  AS q_view_v01_context_session_number,
	FORMAT_TIMESTAMP('%F %T', q_view_v01.property_event_ts ) AS q_view_v01_time_data_points_time,
	q_product_v01.product_interaction_type  AS q_product_v01_product_interaction_type,
	q_product_v01.product_name  AS q_product_v01_product_name,
	q_product_v01.product_color  AS q_product_v01_product_color,
	q_product_v01.product_category  AS q_product_v01_product_category,
	q_product_v01.product_price_baseValue  AS q_product_v01_product_price_base_value,
	q_product_v01.product_manufacturer  AS q_product_v01_product_manufacturer,
	q_product_v01.product_sku  AS q_product_v01_product_sku,
	q_product_v01.product_stock  AS q_product_v01_product_stock,
	q_product_v01.product_size  AS q_product_v01_product_size,
	q_product_v01.product_rating  AS q_product_v01_product_rating,
	q_product_v01.product_subcategory  AS q_product_v01_product_subcategory,
	COUNT(DISTINCT q_transaction_v01.transaction_id)  AS q_transaction_v01_transactions,
	COALESCE(ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE(q_transaction_v01.basket_total_baseValue ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(q_transaction_v01.transaction_id  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6), 0) AS q_transaction_v01_sum_of_transaction_total
FROM `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_view`  AS q_view_v01
LEFT JOIN q_transaction_v01 ON q_view_v01.view_id  = q_transaction_v01.view_id
LEFT JOIN q_product_v01 ON q_product_v01.view_id = q_view_v01.view_id

WHERE ((UPPER(q_view_v01.context_id ) = UPPER('2gavh8ihjvd-0keypz4to-4grxakw'))) AND ((((q_view_v01.property_event_ts ) >= ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -6 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -6 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS DATE), INTERVAL 7 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -6 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP)) AS STRING))))))))
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
ORDER BY 2
LIMIT 500
